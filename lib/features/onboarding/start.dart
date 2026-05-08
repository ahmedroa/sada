import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/curved_top_widget.dart';
import 'package:sada/core/widgets/main_button.dart';
import 'package:sada/features/onboarding/onboarding.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    final logoWidth = (size.width - 40).clamp(0.0, double.infinity);
    final momahSide = (size.shortestSide * 0.36).clamp(96.0, 200.0);
    final gapSm = (size.height * 0.015).clamp(8.0, 20.0);
    final gapLg = (size.height * 0.055).clamp(20.0, 70.0);
    final gapBetweenButtons = (size.height * 0.02).clamp(12.0, 30.0);

    return Scaffold(
      body: Stack(
        children: [
          CurvedTopWidget(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: bottomPad + 12,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          clipBehavior: Clip.none,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: gapSm * 2),
                                Image.asset(
                                  'img/logo.png',
                                  width: logoWidth,
                                  fit: BoxFit.contain,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ' سَدَى',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.primary,
                                      ),
                                    ),
                                    Text(
                                      ' | SADA   ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: gapSm),
                                Text(
                                  'سَدَى..نسيجُ الحدائق المستدام',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: ColorsManager.primary,
                                  ),
                                ),
                                SizedBox(height: gapLg),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: MainButton(
                                    text: 'ابدأ',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Onboarding(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Image.asset(
                    'img/momah.png',
                    width: momahSide,
                    height: momahSide,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
