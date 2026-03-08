import 'package:flutter/material.dart';

class InitiativesTab extends StatelessWidget {
  const InitiativesTab({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Image.asset('img/232323.png', width: double.infinity, height: 200, fit: BoxFit.cover),
        Align(alignment: Alignment.center, child: Image.asset('img/21121.png', width:250, height: 200, fit: BoxFit.cover)),
        SizedBox(height: 16),
        Align(alignment: Alignment.center, child: Image.asset('img/2222123.png', width:double.infinity, height: 200, fit: BoxFit.cover)),
    ],
      ),
    );
  }
}
