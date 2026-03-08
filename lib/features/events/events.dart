import 'package:flutter/material.dart';
import 'package:sada/features/events/widgets/events_tab_bar.dart';
import 'package:sada/features/events/widgets/garden_description_tab.dart';
import 'package:sada/features/events/widgets/initiatives_tab.dart';
import 'package:sada/features/onboarding/reviews.dart';
import 'package:sada/features/reviews/widget/description.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  int _selectedIndex = 0;

  static const List<String> _periods = [
    'الأصدقاء',
    'وصف الحديقه',
    'الفعاليات',
    'المبادرات',
  ];

  static const List<Widget> _tabs = [
    Reviews(),
        Description(),

    GardenDescriptionTab(),
    InitiativesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                      SizedBox(height: 16),

          EventsTabBar(
            periods: _periods,
            selectedIndex: _selectedIndex,
            onTabSelected: (index) => setState(() => _selectedIndex = index),
          ),
          SizedBox(height: 16),
          _tabs[_selectedIndex],
        ],
      ),
    );
  }
}
