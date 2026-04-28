import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  static const _data = [
    _SuggestionItem(
      title: 'إضافة مقاعد في الممرات',
      garden: 'حديقة الخزامى',
      tag: 'مرافق',
      statusLabel: 'تم القبول',
      pct: 100,
    ),
    _SuggestionItem(
      title: 'مظلات للجلوس',
      garden: 'حديقة الورود',
      tag: 'بيئة',
      statusLabel: 'قيد التنفيذ',
      pct: 77,
    ),
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _search.text.trim();
    final list = q.isEmpty
        ? _data
        : _data
              .where(
                (e) =>
                    e.title.contains(q) ||
                    e.garden.contains(q) ||
                    e.tag.contains(q),
              )
              .toList();

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
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...list.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _suggestionTile(e),
          ),
        ),
      ],
    );
  }

  Widget _suggestionTile(_SuggestionItem e) {
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
                // SvgPicture.asset('img/lightbulb.svg', width: 32, height: 32),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        e.title,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              e.garden,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: ColorsManager.gray,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 80),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff34C759).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'مرافق',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تم القبول',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.kPrimaryColo,
                  fontSize: 12,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: MintGradientLinearProgress(
                      value: e.pct / 100,
                      height: 25,
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuggestionItem {
  const _SuggestionItem({
    required this.title,
    required this.garden,
    required this.tag,
    required this.statusLabel,
    required this.pct,
  });

  final String title;
  final String garden;
  final String tag;
  final String statusLabel;
  final int pct;
}
