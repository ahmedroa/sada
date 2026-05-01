import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/mint_gradient_linear_progress.dart';

class ComplaintsPane extends StatefulWidget {
  const ComplaintsPane({super.key, this.shrinkWrap = false});

  final bool shrinkWrap;

  @override
  State<ComplaintsPane> createState() => _ComplaintsPaneState();
}

class _ComplaintsPaneState extends State<ComplaintsPane> {
  int _filter = 0;

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
          .snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(40),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final docs = (snap.data?.docs ?? [])
            .where((d) => (d.data() as Map)['type'] == 'شكوى')
            .toList()
          ..sort((a, b) {
            final ta = (a.data() as Map)['sentAt'] as Timestamp?;
            final tb = (b.data() as Map)['sentAt'] as Timestamp?;
            if (ta == null || tb == null) return 0;
            return tb.compareTo(ta);
          });

        return ListView(
          shrinkWrap: widget.shrinkWrap,
          physics: widget.shrinkWrap ? const NeverScrollableScrollPhysics() : null,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _f('الكل', 0),
                _sep(),
                _f('قيد المعالجة', 1),
                _sep(),
                _f('مكتمل', 2),
              ],
            ),
            const SizedBox(height: 16),
            if (docs.isEmpty)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: Text('لا توجد شكاوي حتى الآن',
                      style: TextStyle(color: Colors.grey)),
                ),
              )
            else
              ...docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final title = data['message'] ?? '';
                final time = _formatTime(data['sentAt'] as Timestamp?);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _complaintTile(title: title, time: time),
                );
              }),
          ],
        );
      },
    );
  }

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
                Icon(Icons.warning_rounded, color: ColorsManager.dark, size: 32),
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
                            fontWeight: FontWeight.bold, fontSize: 15),
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
