import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';

class EventsListTab extends StatelessWidget {
  const EventsListTab({super.key});

  static const List<Map<String, String>> _events = [
    {
      'title': 'مهرجان الجوف التراثي',
      'date': 'الاثنين، 7 جمادى الاول 1446',
      'location': 'منتزه الخزامى',
      'type': 'مهرجان',
    },
    {
      'title': 'يوم النظافة الخضراء',
      'date': 'الجمعة، 11 جمادى الاول 1446',
      'location': 'حديقة الربيع',
      'type': 'تطوعي',
    },
    {
      'title': 'ورشة زراعة النباتات',
      'date': 'السبت، 19 جمادى الاول 1446',
      'location': 'المركز البيئي',
      'type': 'ورشة',
    },
    {
      'title': 'سباق المشي البيئي',
      'date': 'الجمعة، 25 جمادى الاول 1446',
      'location': 'كورنيش الجوف',
      'type': 'رياضي',
    },
  ];

  Color _typeColor(String type) {
    switch (type) {
      case 'مهرجان':
        return ColorsManager.kPrimaryColor;
      case 'تطوعي':
        return ColorsManager.kPrimaryColo;
      case 'ورشة':
        return ColorsManager.yellow;
      default:
        return ColorsManager.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الفعاليات القادمة',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _events.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final event = _events[index];
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _typeColor(event['type']!).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.event, color: _typeColor(event['type']!), size: 26),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  event['title']!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: _typeColor(event['type']!).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  event['type']!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: _typeColor(event['type']!),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined, size: 13, color: ColorsManager.gray),
                              const SizedBox(width: 4),
                              Text(
                                event['date']!,
                                style: const TextStyle(fontSize: 12, color: ColorsManager.gray),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 13, color: ColorsManager.gray),
                              const SizedBox(width: 4),
                              Text(
                                event['location']!,
                                style: const TextStyle(fontSize: 12, color: ColorsManager.gray),
                              ),
                            ],
                          ),
                        ],
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
