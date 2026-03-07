import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';

class InitiativesTab extends StatelessWidget {
  const InitiativesTab({super.key});

  static const List<Map<String, String>> _initiatives = [
    {
      'title': 'مبادرة الشجرة الخضراء',
      'description': 'زراعة 1000 شجرة في مناطق الجوف لتعزيز التشجير',
      'progress': '65',
      'participants': '120 مشارك',
    },
    {
      'title': 'تنظيف الحدائق العامة',
      'description': 'حملة تطوعية لنظافة الحدائق كل شهر',
      'progress': '80',
      'participants': '85 مشارك',
    },
    {
      'title': 'توفير مقاعد الراحة',
      'description': 'تركيب مقاعد مريحة في جميع حدائق المدينة',
      'progress': '40',
      'participants': '30 مشارك',
    },
    {
      'title': 'مسارات الدراجات الهوائية',
      'description': 'انشاء مسارات آمنة للدراجات داخل المناطق الخضراء',
      'progress': '25',
      'participants': '55 مشارك',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'المبادرات البيئية',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _initiatives.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final initiative = _initiatives[index];
              final progress = double.parse(initiative['progress']!) / 100;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.grayBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: ColorsManager.kPrimaryColo.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.eco_outlined,
                            color: ColorsManager.kPrimaryColo,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            initiative['title']!,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      initiative['description']!,
                      style: const TextStyle(fontSize: 13, color: ColorsManager.gray),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${initiative['progress']}%',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.kPrimaryColo,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.people_outline, size: 14, color: ColorsManager.gray),
                            const SizedBox(width: 4),
                            Text(
                              initiative['participants']!,
                              style: const TextStyle(fontSize: 12, color: ColorsManager.gray),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: ColorsManager.lighterGray,
                        valueColor: const AlwaysStoppedAnimation<Color>(ColorsManager.kPrimaryColo),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
