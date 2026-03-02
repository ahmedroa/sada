import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/curved_top_widget.dart';
import 'package:sada/core/widgets/app_text_form_field.dart';
import 'package:sada/core/widgets/main_button.dart';
import 'package:sada/features/auth/register/register.dart';
import 'package:sada/features/home/widgets/bottom_nav_bar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurvedTopWidget(),
            Image.asset('img/logo.png', width: 200, height: 200, fit: BoxFit.cover),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' سَدَى',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorsManager.kPrimaryColor),
                ),
                Text(
                  ' | SADA   ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorsManager.kPrimaryColor),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Image.asset('img/nacath.png'),
                  SizedBox(height: 50),
                  AppTextFormField(
                    hintText: 'البريد الإلكتروني',
                    validator: (String? p1) {
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  AppTextFormField(
                    hintText: 'كلمة المرور',
                    isObscureText: !isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: ColorsManager.kPrimaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    validator: (String? p1) {
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'هل نسيت كلمة المرور؟',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorsManager.kPrimaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  MainButton(
                    text: 'تسجيل الدخول',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لديك حساب؟',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorsManager.gray),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                        },
                        child: Text(
                          'تسجيل',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ColorsManager.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
