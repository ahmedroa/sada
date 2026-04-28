import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';

/// شريط تقدم بتدرج لوني (#2FEA9B ← #7FDD53).
///
/// يتجنب الخطأ عندما لا يقيّد الأب بالعرض (مثل [Column] مع crossAxisAlignment: center دون تمطيط).
class MintGradientLinearProgress extends StatelessWidget {
  const MintGradientLinearProgress({
    super.key,
    required this.value,
    this.height = 8,
  });

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;

        if (!maxW.isFinite || maxW <= 0) {
          return SizedBox(height: height);
        }

        final v = value.clamp(0.0, 1.0);
        final fillW = maxW * v;

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: height,
            width: maxW,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.hardEdge,
              children: [
                const ColoredBox(color: ColorsManager.lighterGray),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox(
                    width: fillW,
                    height: height,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorsManager.gradientMintStart,
                            ColorsManager.gradientMintEnd,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
