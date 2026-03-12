import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sada/features/reviews/screen/review_details.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    final friends = [
      {
        'name': 'خزامى',
        'text':
            'زرت حديقة النخيل اليوم لكن لاحظت أن بعض المناطق مليانة نفايات. وش رايكم نسوي مبادرة تنظيف بسيطة؟',
        'time': 'منذ 12 ساعة',
        'img': 'img/p1.png',
      },
      {
        'name': 'وتين',
        'text':
            'الحديقة اليوم كانت رهيبة! الطقس حلو وناس كثير. أنصح الكل يزورها في الصباح الباكر ',
        'time': 'منذ 3 ساعات',
        'img': 'img/p2.png',
      },
      {
        'name': 'ريما',
        'text':
            'شفت عصافير نادرة اليوم في الحديقة، كانت تجربة جميلة جداً مع العيال',
        'time': 'منذ 5 ساعات',
        'img': 'img/p3.png',
      },
      {
        'name': 'غادة',
        'text':
            'المشاوير حول البحيرة ممتازة للرياضة الصباحية، المكان نظيف ومريح',
        'time': 'منذ 3 أيام',
        'img': 'img/p4.png',
      },
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: friends
                .map(
                  (f) => buildItem(
                    name: f['name']!,
                    text: f['text']!,
                    time: f['time']!,
                    img: f['img']!,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Padding buildItem({
    required String name,
    required String text,
    required String time,
    required String img,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProfileScreen(name: name, img: img, time: time),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 45,
              // backgroundImage: AssetImage(img),
              // width: 120,
              // height: 120,
              child: Image.asset(
                img,
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset('img/loc.svg', width: 20, height: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
