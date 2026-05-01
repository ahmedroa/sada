import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/mint_gradient_linear_progress.dart';

class SuggestionsPane extends StatefulWidget {
  const SuggestionsPane({super.key, this.shrinkWrap = false});

  final bool shrinkWrap;

  @override
  State<SuggestionsPane> createState() => _SuggestionsPaneState();
}

class _SuggestionsPaneState extends State<SuggestionsPane> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

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

        final q = _search.text.trim();
        final docs = (snap.data?.docs ?? [])
            .where((d) {
              final data = d.data() as Map<String, dynamic>;
              if (data['type'] != 'إقتراح') return false;
              if (q.isEmpty) return true;
              return (data['message'] ?? '').contains(q);
            })
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
            TextField(
              controller: _search,
              onChanged: (_) => setState(() {}),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'ابحث عن اقتراح',
                hintStyle: TextStyle(color: ColorsManager.gray),
                prefixIcon: Icon(Icons.search, color: ColorsManager.gray),
                filled: true,
                fillColor: ColorsManager.textFormField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            if (docs.isEmpty)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: Text('لا توجد اقتراحات حتى الآن',
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
                  child: _suggestionTile(title: title, time: time),
                );
              }),
          ],
        );
      },
    );
  }

  Widget _suggestionTile({required String title, required String time}) {
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
                Image.asset('img/lightbulb.png', width: 60, height: 60),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'قيد التنفيذ',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.kPrimaryColo,
                  fontSize: 12,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: const [
                  SizedBox(width: 20),
                  Expanded(
                    child: MintGradientLinearProgress(value: 0.5, height: 25),
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
