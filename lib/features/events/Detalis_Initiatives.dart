import 'package:flutter/material.dart';

class DetalisInitiatives extends StatelessWidget {
  const DetalisInitiatives({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text('تفاصيل المبادرة'),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26, top: 20),
        child: Column(
          children: [
            Image.asset(
              'img/232323.png',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'img/21121.png',
                width: 250,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'img/2222123.png',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
