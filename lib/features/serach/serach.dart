import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/app_text_form_field.dart';

class Serach extends StatefulWidget {
  const Serach({super.key});

  @override
  State<Serach> createState() => _SerachState();
}

class _SerachState extends State<Serach> {
  int _selectedPeriodIndex = 0;

  static const List<String> _periods = ['الحدائق', 'الأشجار والنباتات', 'مواقف', 'الاكل والشراب'];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
                        SizedBox(height: 16),

            AppTextFormField(
              hintText: 'البحث',
              validator: (String? value) {
                return null;
              },
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[100]!, width: .2),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
              fillColor: Colors.grey[200],
              prefixIcon: Icon(Icons.search),
            ),
            const SizedBox(height: 16),
            _buildPeriodOptions(),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('الاقرب', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                Icon(Icons.arrow_downward, size: 13),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: 
                  [
                    buildItem(
                      name: 'حديقة النخيل',
                      location: 'الاقرب',
                      image: 'img/test.jpg',
                    ),
                    SizedBox(height: 16),
                    buildItem(
                      name: 'حديقة الخزامى',
                      location: 'الاقرب',
                      image: 'img/Group 6265788.png',
                    ),
                    SizedBox(height: 16),
                    buildItem(
                      name: 'حديقة العزيزية',
                      location: 'الاقرب',
                      image: 'img/5345.png',
                    ),
                    SizedBox(height: 16),
                    buildItem(
                      name: 'حديقة المبخرة',
                      location: 'الاقرب',
                      image: 'img/9843.png',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildItem({
    required String name,
    required String location,
    required String image,
  }) {
    return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(image, width: 100, height: 100, fit: BoxFit.cover),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(location, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(width: 10),
              Text('4.5', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              Icon(Icons.star_rate, size: 13, color: Colors.yellow),
            ],
          );
  }

  Widget _buildPeriodOptions() {
    return Row(
      children: List.generate(_periods.length, (index) {
        final isSelected = index == _selectedPeriodIndex;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: index > 0 ? 4 : 0, right: index < _periods.length - 1 ? 4 : 0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => setState(() => _selectedPeriodIndex = index),
                borderRadius: BorderRadius.circular(24),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xff0D986A) : ColorsManager.lighterGray,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _periods[index],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : ColorsManager.gray,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
