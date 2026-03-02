import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/features/reviews/widget/Initiatives_widget.dart';
import 'package:sada/features/reviews/widget/description.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  int _selectedPeriodIndex = 0;

  static const List<String> _periods = ['الأصدقاء', 'وصف الحديقه', 'الفعاليات', 'المبادرات'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [SizedBox(height: 16), _buildPeriodOptions(), SizedBox(height: 16), _buildSelectedContent()],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedContent() {
    switch (_selectedPeriodIndex) {
      case 0: // الأصدقاء
        return Column(
          children: [buildItem(), buildItem(), buildItem(), buildItem(), buildItem(), buildItem(), buildItem()],
        );
      case 1:
        return Description();
      case 2:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: List.generate(3, (i) {
              final events = [
                {'title': 'ماراثون الحديقة', 'date': '١ مارس ٢٠٢٥', 'icon': Icons.directions_run},
                {'title': 'يوم التشجير', 'date': '١٥ مارس ٢٠٢٥', 'icon': Icons.park},
                {'title': 'معرض الصور الطبيعية', 'date': '٢٠ مارس ٢٠٢٥', 'icon': Icons.photo_camera},
              ];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xff0D986A).withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Color(0xff0D986A).withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(events[i]['icon'] as IconData, color: Color(0xff0D986A), size: 24),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(events[i]['title'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(events[i]['date'] as String, style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      case 3:
        return InitiativesWidget();
      default:
        return SizedBox.shrink();
    }
  }

  Padding buildItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Icon(Icons.person, color: ColorsManager.kPrimaryColor, size: 20),
          Image.asset('img/image 5.png', width: 120, height: 120, fit: BoxFit.cover),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'خزامى',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(width: 16),
                    SvgPicture.asset('img/loc.svg', width: 24, height: 24),
                  ],
                ),
                Text(
                  ' زرت حديقة النخيل اليوم لكن لاحظت أن بعض المناطق مليانة نفايات.  وش رايكم نسوي مبادرة تنظيف بسيطة؟ 🌿',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Spacer(),
          Text(
            'منذ 12 ساعة',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
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
