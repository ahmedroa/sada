import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sada/core/widgets/main_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: double.infinity,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                'الصفحه الئيسيه',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xff0A5E3F)),
              ),
            ),
            Text(
              'أهلاً',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xff0A5E3F)),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                SizedBox(width: 16),
                Text('الرياض, المملكة العربية السعودية'),
              ],
            ),

            SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Color(0xffDEEAD8),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('img/aaaa.svg'),
                                  SizedBox(width: 16),
                                  Text(
                                    'حديقة النخيل',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff0A5E3F),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: Image.asset('img/test.jpg', width: 140, height: 150, fit: BoxFit.cover),
                              ),
                              SizedBox(height: 16),
                              SizedBox(width: 140, height: 40),
                              // MainButton(
                              //   text: 'Live view',
                              //   onTap: () {
                              //     Navigator.push(context, MaterialPageRoute(builder: (context) => LiveView()));
                              //   },
                              //   width: 140,
                              //   height: 40,
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              buildItem(title: 'صحة النباتات', value: '70-75%', icon: 'img/Group 174.svg'),
                              SizedBox(height: 16),
                              buildItem(title: 'حالة الألعاب', value: 'حالة الالعاب', icon: 'img/Vector (3).svg'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              buildItem(title: 'الشمس', value: 'مشمس  30ْ', icon: 'img/sh.svg'),
                              SizedBox(height: 16),
                              buildItem(title: 'نسبة  الإزدحام', value: '30%', icon: 'img/persons.svg'),
                              SizedBox(height: 16),
                              buildItem(title: 'استهلاك المياه', value: '80%', icon: 'img/as.svg'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage('img/photo_1447-09-10 22.04.36.jpeg'),
                    fit: BoxFit.cover,
                    opacity: 0.69,
                  ),
                ),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ساهم في زرع 1000 نبته \n في حدائق منطقة الجوف',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[100]),
                        ),
                        SizedBox(width: 16),
                        MainButton(
                          text: 'شارك الآن',
                          onTap: () {},
                          width: 140,
                          height: 40,
                          color: Color(0xff1B2F29).withOpacity(.8),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                            width: 30,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                            width: 30,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildItem({required String title, required String value, required String icon}) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff013220)),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xff0D986A)),
        ),
      ],
    );
  }
}
