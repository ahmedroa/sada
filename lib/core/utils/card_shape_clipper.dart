import 'package:flutter/material.dart';

/// Clipper for the top green card: only a large concave (inward) curve
/// on bottom-left. Rest of the corners are sharp (no rounding).
class CardWithConcaveClipper extends CustomClipper<Path> {
  final double concaveRadius;

  CardWithConcaveClipper({this.concaveRadius = 56});

  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final cr = concaveRadius;

    // Top-left corner: sharp
    path.moveTo(0, 0);
    // Top edge
    path.lineTo(w, 0);
    // Top-right: sharp, right edge
    path.lineTo(w, h);
    // Bottom edge until start of concave
    path.lineTo(cr, h);
    // Concave curve (scoop) on bottom-left only
    path.quadraticBezierTo(0, h, 0, h - cr);
    // Left edge back to top
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
