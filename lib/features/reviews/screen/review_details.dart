import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sada/core/theme/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.)),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset('img/minu.svg'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                        border: Border.all(
                          color: ColorsManager.kPrimaryColor,
                          width: 8,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.person),
                      ),
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
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'مبادرتي',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0B6C48),
                  ),
                ),
                SizedBox(height: 10),
                buildItem(),
                Divider(color: Colors.black, height: 1, thickness: 1),
                buildVisits(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              children: [
                Text(
                  'منذ 3 ساعة',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff000000).withOpacity(.5),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xff000000).withOpacity(.5),
                  size: 16,
                ),
              ],
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'img/9843.png',
                  width: 120,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),

              Expanded(
                child: Text(
                  ' قمت بتجديد التربة لحدائق المروج خلال حملة التحديات',
                  style: TextStyle(
                    color: Color(0xff000000).withOpacity(.5),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildVisits() {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Row(
            children: [
              Text(
                'منذ 3 ساعة',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff000000).withOpacity(.5),
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_drop_down,
                color: Color(0xff000000).withOpacity(.5),
                size: 16,
              ),
            ],
          ),
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'img/9843.png',
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: Text(
                ' قمت بتجديد التربة لحدائق المروج خلال حملة التحديات',
                style: TextStyle(
                  color: Color(0xff000000).withOpacity(.5),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
