import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(color: Color(0xFF0D986A), borderRadius: BorderRadius.circular(50)),
          child: Icon(Icons.person, color: Colors.white),
        ),
        SizedBox(height: 20),
        Container(
          width: 120,

          decoration: BoxDecoration(color: Color(0xFF0D986A).withOpacity(.9), borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                SvgPicture.asset('img/edit.svg'),
                Text(
                  'تعديل',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        buildItem(title: 'المفضلة', icon: 'img/f.svg'),
        buildItem(title: 'الشكاوي والإقتراحات', icon: 'img/qq.svg'),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 30),
          child: const Divider(color: Colors.black, height: 1),
        ),
        SizedBox(height: 20),

        buildItem(title: 'اللغة', icon: 'img/language.svg'),
        buildItem(title: 'الاشعارات', icon: 'img/notfiction.svg'),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 30),
          child: const Divider(color: Colors.black, height: 1),
        ),
        SizedBox(height: 20),

        buildItem(title: 'الامان', icon: 'img/s.svg'),
        buildItem(title: 'عن سدى', icon: 'img/sss.svg'),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 30),
          child: const Divider(color: Colors.black, height: 1),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تسجيل الخروج',
              style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 10),
            Icon(Icons.login_outlined, color: Colors.black, size: 16),
          ],
        ),
      ],
    );
  }

  Widget buildItem({required String title, required String icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, top: 12, bottom: 12),
      child: Row(
        children: [
          Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(width: 16),
          SizedBox(width: 24, height: 24, child: SvgPicture.asset(icon, width: 24, height: 24, fit: BoxFit.contain)),
          SizedBox(width: 40),
        ],
      ),
    );
  }
}
