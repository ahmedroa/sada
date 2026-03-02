import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sada/core/theme/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_new)),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.)),
          Padding(padding: const EdgeInsets.only(left: 16), child: SvgPicture.asset('img/minu.svg')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: ColorsManager.kPrimaryColor, width: 8),
                      ),
                      child: Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.person)),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff0D986A).withOpacity(.49),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'متابعة',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff0D986A).withOpacity(.76),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'مشاركة',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff0D986A).withOpacity(.76),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'الاسم',
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 18, left: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مبادرتي',
                    style: TextStyle(color: Color(0xff0B6C48), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      'منذ 1 ساعة',
                      style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                  buildItem(),
                  Container(width: double.infinity, height: 1, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildItem() {
    return Row(
      children: [
        Image.asset('img/image 5.png', width: 100, height: 100, fit: BoxFit.cover),

        Expanded(
          child: Text(
            ' قمت بتجديد التربة لحدائق المروج خلال حملة التحديات البيئية🌿',
            style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
