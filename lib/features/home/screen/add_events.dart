import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/app_text_form_field.dart';
import 'package:sada/core/widgets/main_button.dart';

class AddEvents extends StatelessWidget {
  const AddEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'img/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'نموذج معلومات الفعالية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff013220),
                ),
              ),
              SizedBox(height: 20),
              AppTextFormField(
                hintText: 'إسم الفعالية',

                fillColor: Color(0xffE5E5E5).withOpacity(.37),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff307E29), width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب أن يكون لديك إسم الفعالية';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              AppTextFormField(
                hintText: 'التاريخ',

                fillColor: Color(0xffE5E5E5).withOpacity(.37),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff307E29), width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب أن يكون لديك إسم الفعالية';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              AppTextFormField(
                hintText: 'الموقع',

                fillColor: Color(0xffE5E5E5).withOpacity(.37),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff307E29), width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب أن يكون لديك إسم الفعالية';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              AppTextFormField(
                hintText: 'الوصف',
                maxLines: 3,
                fillColor: Color(0xffBDD4BA).withOpacity(.43),

                // borderRadius: BorderRadius.circular(10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff307E29), width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب أن يكون لديك إسم الفعالية';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'قم بأرفاق صور إن وجد :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff013220),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 180,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff7B968D).withOpacity(.37),
                  borderRadius: BorderRadius.circular(16),
                ),
                // child: Text('أرفق صورة'),
              ),
              SizedBox(height: 20),
              MainButton(
                width: 130,
                height: 40,
                borderRadius: 10,
                text: 'نشر',
                onTap: () {},
                color: Color(0xff0D986A).withOpacity(.76),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
