import 'package:flutter/material.dart';

class CurvedTopWidget extends StatelessWidget {
  final double height;
  final List<Color>? colors;

  const CurvedTopWidget({super.key, this.height = 100, this.colors});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedTopClipper(),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors ?? [Color(0xff12563d).withOpacity(.86), Color(0xff12563d).withOpacity(.86)],
          ),
        ),
      ),
    );
  }
}

// CustomClipper لإنشاء الشكل المنحني
class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // نبدأ من الزاوية اليسرى العليا
    path.lineTo(0, 0);

    // نرسم الخط العلوي
    path.lineTo(size.width, 0);

    // نرسم الخط الأيمن
    path.lineTo(size.width, size.height * 0.6);

    // نرسم المنحنى السفلي
    var firstControlPoint = Offset(size.width * 0.75, size.height);
    var firstEndPoint = Offset(size.width * 0.5, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.25, size.height);
    var secondEndPoint = Offset(0, size.height * 0.6);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    // نغلق المسار
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
