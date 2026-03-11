import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sada/core/theme/colors.dart';

class GardenDetails extends StatelessWidget {
  final String name;
  final String distance;
  final String image;

  const GardenDetails({
    super.key,
    required this.name,
    required this.distance,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'img/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Container(
            // height: 300,
            decoration: BoxDecoration(
              color: Color(0xffDEEAD8),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xff0D986A),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  const Text(
                                    '4.5',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.star_rate,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            distance,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Image.asset(
                      image,
                      width: 280,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.favorite,
                            size: 24,
                            color: ColorsManager.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 18, left: 18),
            child: Text(
              'المرافق المتاحة',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18, left: 18),
            child: Divider(color: Colors.grey, height: 1),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('img/maki_toilet.png', width: 50, height: 50),
              SizedBox(width: 10),
              Image.asset('img/Parking.png', width: 50, height: 50),
              SizedBox(width: 10),
              Image.asset('img/FoodTruck.png', width: 50, height: 50),
              SizedBox(width: 10),
              Image.asset('img/Playground.png', width: 50, height: 50),
              SizedBox(width: 10),
              Image.asset('img/Stadium.png', width: 50, height: 50),
            ],
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff0D986A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'الموقع',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}
