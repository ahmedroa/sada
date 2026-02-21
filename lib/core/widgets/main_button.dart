import 'package:flutter/material.dart';

import '../theme/colors.dart';

class MainButton extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final bool hasCircularBorder;
  final double width;
  final double height;
  final double borderRadius;
  final Color color;
  final Color colortext;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget? icon;
  const MainButton({
    super.key,
    required this.text,
    required this.onTap,
    this.hasCircularBorder = false,
    this.color = ColorsManager.kPrimaryColor,
    this.colortext = Colors.white,
    this.width = double.infinity,
    this.height = 70,
    this.fontSize = 20,
    this.borderRadius = 10,
    this.fontWeight = FontWeight.w600,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius), color: Color(0xff0D986A)),
        child: MaterialButton(
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(color: colortext, fontSize: fontSize, fontWeight: fontWeight),
              ),
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
            ],
          ),
        ),
      ),
    );
  }
}
