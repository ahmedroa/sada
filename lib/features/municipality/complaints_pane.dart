import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/mint_gradient_linear_progress.dart';

class ComplaintsPane extends StatefulWidget {
  const ComplaintsPane({super.key, this.shrinkWrap = false});

  /// عند `true`: الارتفاع بحجم المحتوى فقط (مع تمرير من الأب).
  final bool shrinkWrap;

  @override
  State<ComplaintsPane> createState() => _ComplaintsPaneState();
}

class _ComplaintsPaneState extends State<ComplaintsPane> {
  int _filter = 0;

  static const _data = [
    _ComplaintItem(
      title: 'إنارة الحديقة لا تعمل ليلاً',
      sub: 'حديقة الخزامى',
      time: 'قبل ساعتين',
      pct: 100,
      done: true,
    ),
    _ComplaintItem(
      title: 'تسرب مياه في الممرات',
      sub: 'حديقة النخيل',
      time: 'أمس',
      pct: 100,
      done: true,
    ),
    _ComplaintItem(
      title: 'تراكم النفايات في الحديقة',
      sub: 'حديقة الدرعية',
      time: 'قبل 5 ساعات',
      pct: 87,
      done: false,
    ),
  ];

  Iterable<_ComplaintItem> get _list {
    if (_filter == 1) return _data.where((e) => !e.done);
    if (_filter == 2) return _data.where((e) => e.done);
    return _data;
  }

  @override
  Widget build(BuildContext context) {
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
        ..._list.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _complaintTile(e),
          ),
        ),
      ],
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

  Widget _complaintTile(_ComplaintItem e) {
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
                              e.sub,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: ColorsManager.gray,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              e.time,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: ColorsManager.gray,
                                fontSize: 12,
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
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              // const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    e.done ? 'مكتمل' : 'قيد المعالجة',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ColorsManager.kPrimaryColo,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${e.pct}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MintGradientLinearProgress(
                  value: e.pct / 100,
                  height: 17,
                ),
              ),
              const SizedBox(width: 30),
            ],
          ),
        ],
      ),
    );
  }
}

class _ComplaintItem {
  const _ComplaintItem({
    required this.title,
    required this.sub,
    required this.time,
    required this.pct,
    required this.done,
  });
  final String title;
  final String sub;
  final String time;
  final int pct;
  final bool done;
}
