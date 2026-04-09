// import 'package:flutter/material.dart';
// import 'package:sada/core/widgets/main_button.dart';

// class Description extends StatefulWidget {
//   const Description({super.key});

//   @override
//   State<Description> createState() => _DescriptionState();
// }

// class _DescriptionState extends State<Description> {
//   int _selectedStars = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 24),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Color(0xff3E7358),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'حديقة الخزامى ',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 ' واحة طبيعية تجمع بين المساحات الخضراء، ممرات المشي، وأزهار الخزامى العطرة. المكان المثالي للاسترخاء، التنزه، والاستمتاع بالهواء النقي! ',
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.white,
//                   height: 1.6,
//                 ),
//               ),
//               SizedBox(height: 12),
//               Row(
//                 children: [
//                   Icon(Icons.location_on, color: Color(0xff0D986A), size: 18),
//                   SizedBox(width: 4),
//                   Text(
//                     'الرياض، المملكة العربية السعودية',
//                     style: TextStyle(fontSize: 12, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16),
//         Text(
//           'قيم كيف ترى الحديقة!',
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.bold,
//             color: Color(0xff0D986A),
//           ),
//         ),
//         SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(5, (i) {
//             final index = i + 1;
//             return GestureDetector(
//               onTap: () => setState(() => _selectedStars = index),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4),
//                 child: Icon(
//                   index <= _selectedStars ? Icons.star : Icons.star_border,
//                   color: const Color(0xff0D986A),
//                   size: 26,
//                 ),
//               ),
//             );
//           }),
//         ),
//         SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'أضف صورة لأجمل لقطة التقطتها!',
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(width: 8),
//             Icon(Icons.camera_alt_outlined, color: Colors.black, size: 26),
//           ],
//         ),
//         SizedBox(height: 16),

//         MainButton(
//           text: 'إرسال',
//           onTap: () {},
//           width: 160,
//           borderRadius: 30,
//           height: 40,
//         ),
//       ],
//     );
//   }
// }
