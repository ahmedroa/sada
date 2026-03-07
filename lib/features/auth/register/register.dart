import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/app_text_form_field.dart';
import 'package:sada/core/widgets/curved_top_widget.dart';
import 'package:sada/core/widgets/main_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPasswordVisible = false;
  bool acceptTerms = false;

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
                  AppTextFormField(
                    hintText: 'البريد الإلكتروني',
                    validator: (String? p1) {
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  AppTextFormField(
                    hintText: 'رقم الجوال',
                    validator: (String? p1) {
                      return null;
                    },
                    keyboardType: TextInputType.phone,
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
                  SizedBox(height: 20),
                  AppTextFormField(
                    hintText: 'تأكيد كلمة المرور',
                    isObscureText: !isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: ColorsManager.kPrimaryColor,
                      ),
                      onPressed: () {},
                    ),
                    validator: (String? p1) {
                      return null;
                    },
                  ),

                  SizedBox(height: 20),

                  // Terms and Conditions Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: acceptTerms,
                          onChanged: (bool? value) {
                            setState(() {
                              acceptTerms = value ?? false;
                            });
                          },
                          activeColor: ColorsManager.kPrimaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 13,
                                color: ColorsManager.gray,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(text: 'بالتسجيل فإنك توافق على '),
                                TextSpan(
                                  text: 'الشروط والأحكام',
                                  style: TextStyle(
                                    color: ColorsManager.kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: ' و'),
                                TextSpan(
                                  text: 'سياسة الخصوصية',
                                  style: TextStyle(
                                    color: ColorsManager.kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  MainButton(text: 'تسجيل', onTap: () {}),
                    SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لديك حساب؟',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorsManager.gray),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ColorsManager.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 30),

                  // Or sign up with
                  Row(
                    children: [
                      Expanded(child: Divider(color: ColorsManager.gray.withOpacity(0.3), thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'أو سجل باستخدام',
                          style: TextStyle(fontSize: 14, color: ColorsManager.gray, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(child: Divider(color: ColorsManager.gray.withOpacity(0.3), thickness: 1)),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Google Sign In Button
                  InkWell(
                    onTap: () {
                      // Google sign in logic here
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorsManager.gray.withOpacity(0.08), width: 1.5),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 4)),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://www.google.com/images/branding/googleg/1x/googleg_standard_color_128dp.png',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Google',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
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
