import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  static const List<Map<String, String>> _friends = [
    {'name': 'عبدالله العمري', 'status': 'سيحضر'},
    {'name': 'نورة السالم', 'status': 'سيحضر'},
    {'name': 'فهد المطيري', 'status': 'ربما'},
    {'name': 'سارة الغامدي', 'status': 'لن يحضر'},
    {'name': 'خالد الدوسري', 'status': 'سيحضر'},
    {'name': 'منى الزهراني', 'status': 'ربما'},
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'سيحضر':
        return ColorsManager.kPrimaryColo;
      case 'ربما':
        return ColorsManager.yellow;
      default:
        return ColorsManager.red;
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
            'الأصدقاء المدعوون',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _friends.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final friend = _friends[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: ColorsManager.lighterGray,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: ColorsManager.kPrimaryColo.withOpacity(0.15),
                      child: Text(
                        friend['name']![0],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.kPrimaryColo,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        friend['name']!,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor(friend['status']!).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        friend['status']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _statusColor(friend['status']!),
                        ),
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
