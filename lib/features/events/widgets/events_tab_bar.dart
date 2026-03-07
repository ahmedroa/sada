import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';

class EventsTabBar extends StatelessWidget {
  const EventsTabBar({
    super.key,
    required this.periods,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final List<String> periods;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final gap = (w * 0.01).clamp(4.0, 8.0);
    final fontSize = (w * 0.032).clamp(12.0, 15.0);
    final verticalPadding = (w * 0.028).clamp(10.0, 14.0);

    return Row(
      children: List.generate(periods.length, (index) {
        final isSelected = index == selectedIndex;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index > 0 ? gap : 0,
              right: index < periods.length - 1 ? gap : 0,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onTabSelected(index),
                borderRadius: BorderRadius.circular(24),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: verticalPadding),
                  decoration: BoxDecoration(
                    color: isSelected ? ColorsManager.kPrimaryColo : ColorsManager.lighterGray,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    periods[index],
                    style: TextStyle(
                      fontSize: fontSize,
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
