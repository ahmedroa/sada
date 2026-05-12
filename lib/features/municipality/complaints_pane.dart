import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/mint_gradient_linear_progress.dart';

class ComplaintsPane extends StatefulWidget {
  const ComplaintsPane({
    super.key,
    this.shrinkWrap = false,
    this.limit,
    this.onTotal,
  });

  final bool shrinkWrap;
  final int? limit;
  final void Function(int total)? onTotal;

  @override
  State<ComplaintsPane> createState() => _ComplaintsPaneState();
}

class _ComplaintsPaneState extends State<ComplaintsPane> {
  int _filter = 0;
  int? _lastTotal;

  String _formatTime(Timestamp? ts) {
    if (ts == null) return '';
    final diff = DateTime.now().difference(ts.toDate());
    final mins = diff.inMinutes;
    final hours = diff.inHours;
    final days = diff.inDays;

    if (mins < 1) return 'الآن';
    if (mins < 60) return 'قبل $mins دقيقة';
    if (hours < 24) return 'قبل $hours ساعة';
    if (days == 1) return 'أمس';
    if (days < 7) return 'قبل $days أيام';
    if (days < 14) return 'الأسبوع الماضي';
    if (days < 30) return 'قبل ${(days / 7).floor()} أسابيع';
    if (days < 60) return 'هذا الشهر';
    if (days < 365) return 'قبل ${(days / 30).floor()} أشهر';
    return 'قبل ${(days / 365).floor()} سنة';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Complaints and suggestions')
          .orderBy('sentAt', descending: true)
          .snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(40),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final allDocs = (snap.data?.docs ?? [])
            .where((d) => (d.data() as Map)['type'] == 'شكوى')
            .toList();

        if (_lastTotal != allDocs.length) {
          _lastTotal = allDocs.length;
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => widget.onTotal?.call(allDocs.length),
          );
        }

        final docs = widget.limit != null
            ? allDocs.take(widget.limit!).toList()
            : allDocs;

        return ListView(
          shrinkWrap: widget.shrinkWrap,
          physics: widget.shrinkWrap
              ? const NeverScrollableScrollPhysics()
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     _f('الكل', 0),
            //     _sep(),
            //     _f('قيد المعالجة', 1),
            //     _sep(),
            //     _f('مكتمل', 2),
            //   ],
            // ),
            const SizedBox(height: 16),
            if (docs.isEmpty)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: Text(
                    'لا توجد شكاوي حتى الآن',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ...docs.toList().map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final title = data['message'] ?? '';
                final time = _formatTime(data['sentAt'] as Timestamp?);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () => _showDetailSheet(context, data),
                    child: _complaintTile(title: title, time: time),
                  ),
                );
              }),
          ],
        );
      },
    );
  }

  void _showDetailSheet(BuildContext context, Map<String, dynamic> data) {
    final ts = data['sentAt'] as Timestamp?;
    final date = ts != null
        ? '${ts.toDate().day.toString().padLeft(2, '0')}/${ts.toDate().month.toString().padLeft(2, '0')}/${ts.toDate().year}  •  ${ts.toDate().hour.toString().padLeft(2, '0')}:${ts.toDate().minute.toString().padLeft(2, '0')}'
        : '—';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Color(0xffF7F8FA),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              // ── Handle
              const SizedBox(height: 10),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // ── Green header
              Container(
                margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff0D986A), Color(0xff0bbf82)],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.warning_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            data['name'] ?? '—',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            date,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: .8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .4),
                        ),
                      ),
                      child: Text(
                        data['type'] ?? 'شكوى',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // ── Scrollable content
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  children: [
                    // Info card
                    _sectionCard(
                      children: [
                        _infoTile(
                          Icons.badge_outlined,
                          'رقم الهوية',
                          data['nationalId'] ?? '—',
                        ),
                        _divider(),
                        _infoTile(
                          Icons.email_outlined,
                          'البريد الإلكتروني',
                          data['email'] ?? '—',
                        ),
                        _divider(),
                        _infoTile(
                          Icons.phone_outlined,
                          'رقم الجوال',
                          data['phone'] ?? '—',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Message card
                    _sectionCard(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: const [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 16,
                                color: Color(0xff0D986A),
                              ),
                              SizedBox(width: 6),
                              Text(
                                'الرسالة',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff0D986A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
                          child: Text(
                            data['message'] ?? '—',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.65,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Attachment card
                    if (data['attachmentName'] != null) ...[
                      const SizedBox(height: 10),
                      _sectionCard(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                const Icon(
                                  Icons.attach_file,
                                  size: 18,
                                  color: Color(0xff0D986A),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    data['attachmentName'],
                                    textDirection: TextDirection.ltr,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // ── Print button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                child: ElevatedButton.icon(
                  onPressed: () => _printComplaint(data, date),
                  icon: const Icon(Icons.print_outlined, size: 18),
                  label: const Text(
                    'طباعة',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0D986A),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _printComplaint(Map<String, dynamic> data, String date) async {
    final regularFont = await PdfGoogleFonts.cairoRegular();
    final boldFont = await PdfGoogleFonts.cairoBold();

    final doc = pw.Document();

    pw.TextStyle style(double size, {bool bold = false}) => pw.TextStyle(
      font: bold ? boldFont : regularFont,
      fontSize: size,
    );

    pw.Widget row(String label, String value) => pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          pw.Text(value, style: style(11), textDirection: pw.TextDirection.rtl),
          pw.SizedBox(width: 8),
          pw.Text(':', style: style(11, bold: true)),
          pw.Text(label, style: style(11, bold: true), textDirection: pw.TextDirection.rtl),
        ],
      ),
    );

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        build: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            // Header
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: pw.BoxDecoration(
                color: const PdfColor.fromInt(0xff0D986A),
                borderRadius: pw.BorderRadius.circular(12),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'تفاصيل الشكوى',
                    style: style(18, bold: true).copyWith(color: PdfColors.white),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    date,
                    style: style(10).copyWith(color: PdfColors.white),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            // Info section
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.circular(10),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  row('النوع', data['type'] ?? '—'),
                  pw.Divider(color: PdfColors.grey300),
                  row('الاسم', data['name'] ?? '—'),
                  pw.Divider(color: PdfColors.grey300),
                  row('رقم الهوية', data['nationalId'] ?? '—'),
                  pw.Divider(color: PdfColors.grey300),
                  row('البريد الإلكتروني', data['email'] ?? '—'),
                  pw.Divider(color: PdfColors.grey300),
                  row('رقم الجوال', data['phone'] ?? '—'),
                ],
              ),
            ),
            pw.SizedBox(height: 16),
            // Message section
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text('الرسالة', style: style(12, bold: true), textDirection: pw.TextDirection.rtl),
            ),
            pw.SizedBox(height: 6),
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(14),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Text(
                data['message'] ?? '—',
                style: style(12),
                textDirection: pw.TextDirection.rtl,
                textAlign: pw.TextAlign.right,
              ),
            ),
            if (data['attachmentName'] != null) ...[
              pw.SizedBox(height: 16),
              row('المرفق', data['attachmentName']),
            ],
          ],
        ),
      ),
    );

    final pdfBytes = await doc.save();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _PdfPreviewScreen(
          title: 'شكوى - ${data['name'] ?? ''}',
          pdfBytes: pdfBytes,
        ),
      ),
    );
  }

  Widget _sectionCard({required List<Widget> children}) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Icon(icon, size: 17, color: const Color(0xff0D986A)),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Divider(height: 1, indent: 42, endIndent: 14, color: Colors.grey[100]);

  Widget _f(String t, int i) {
    final on = _filter == i;
    return GestureDetector(
      onTap: () => setState(() => _filter = i),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Text(
          t,
          style: TextStyle(
            fontSize: 14,
            fontWeight: on ? FontWeight.w800 : FontWeight.w500,
            color: on ? ColorsManager.kPrimaryColo : ColorsManager.gray,
          ),
        ),
      ),
    );
  }

  Widget _sep() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Text('|', style: TextStyle(color: ColorsManager.lightGray)),
  );

  Widget _complaintTile({required String title, required String time}) {
    return Container(
      height: 140,
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: ColorsManager.dark,
                  size: 32,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          time,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ColorsManager.gray,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 80),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'قيد المعالجة',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ColorsManager.kPrimaryColo,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    '0%',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: MintGradientLinearProgress(value: 0.5, height: 17),
              ),
              const SizedBox(width: 30),
            ],
          ),
        ],
      ),
    );
  }
}

class _PdfPreviewScreen extends StatelessWidget {
  const _PdfPreviewScreen({required this.title, required this.pdfBytes});

  final String title;
  final Uint8List pdfBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: PdfPreview(
        build: (_) async => pdfBytes,
        allowPrinting: true,
        allowSharing: true,
        canChangePageFormat: false,
        canChangeOrientation: false,
        pdfPreviewPageDecoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: .08), blurRadius: 6),
          ],
        ),
        actions: [
          PdfPreviewAction(
            icon: const Icon(Icons.print_outlined, color: Color(0xff0D986A)),
            onPressed: (ctx, build, pageFormat) async {
              await Printing.layoutPdf(onLayout: (_) async => pdfBytes);
            },
          ),
        ],
      ),
    );
  }
}
