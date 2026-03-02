import 'package:flutter/material.dart';

// class InitiativesWidget extends StatelessWidget {
//   const InitiativesWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }



class InitiativesWidget extends StatelessWidget {
  const InitiativesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: List.generate(3, (i) {
          final initiatives = [
            {'title': 'مبادرة تنظيف الحديقة', 'members': '٢٤ مشارك', 'color': Color(0xff4CAF50)},
            {'title': 'زراعة ١٠٠٠ شجرة', 'members': '٥٨ مشارك', 'color': Color(0xff2196F3)},
            {'title': 'توفير مظلات للزوار', 'members': '١٢ مشارك', 'color': Color(0xffFF9800)},
          ];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (initiatives[i]['color'] as Color).withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: (initiatives[i]['color'] as Color).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.volunteer_activism, color: initiatives[i]['color'] as Color, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        initiatives[i]['title'] as String,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(initiatives[i]['members'] as String, style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
          );
        }),
      ),
    );
  }
}
