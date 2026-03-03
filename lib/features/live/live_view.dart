import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LiveView extends StatelessWidget {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('img/logo.png', width: 100, height: 100, fit: BoxFit.cover),
        centerTitle: true,
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        // leading: SvgPicture.asset('img/notifications.svg', width: 24, height: 24),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset('img/notifications.svg', width: 24, height: 24),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Live View | تقنية الواقع المعزز',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff013220)),
                ),
                SizedBox(height: 10),
                Image.asset('img/rectangle.png', width: double.infinity, fit: BoxFit.cover),
                SizedBox(height: 10),
                Image.asset('img/Rectangle1.png', width: double.infinity, fit: BoxFit.cover),
                SizedBox(height: 10),
                Image.asset('img/rectangle.png', width: double.infinity, fit: BoxFit.cover),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
