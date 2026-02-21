import 'package:flutter/material.dart';

class LiveView extends StatelessWidget {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
