import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/features/events/events.dart';
import 'package:sada/features/reviews/screen/reviews.dart';
import 'package:sada/features/serach/serach.dart';
import 'package:sada/features/setting/screens/setting.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 3;

  static final List<Widget> _widgetOptions = <Widget>[
    // const Home(),
    Container(),
    // const LiveView(),
    const Events(),
    const Serach(),
    const Setting(),
    const Reviews(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorsManager.backgroundColor,
      backgroundColor: Colors.white,
      appBar: _selectedIndex == 0
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              title: Image.asset('img/logo.png', width: 100, height: 100, fit: BoxFit.cover),
              centerTitle: true,
              // leading: IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
              // leading: SvgPicture.asset('img/notifications.svg', width: 24, height: 24),
              // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.notifications))],
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.notification_add_outlined)),
            ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorsManager.lighterGrayBottom,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, -2))],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    border: _selectedIndex == 0
                        ? Border(bottom: BorderSide(color: ColorsManager.dark, width: 2))
                        : null,
                  ),
                  padding: const EdgeInsets.only(bottom: 4),
                  child: SvgPicture.asset('img/home.svg', width: 24, height: 24),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    border: _selectedIndex == 1
                        ? Border(bottom: BorderSide(color: ColorsManager.dark, width: 2))
                        : null,
                  ),
                  padding: const EdgeInsets.only(bottom: 4),
                  child: SvgPicture.asset('img/xx.svg', width: 24, height: 24),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    border: _selectedIndex == 2
                        ? Border(bottom: BorderSide(color: ColorsManager.dark, width: 2))
                        : null,
                  ),
                  padding: const EdgeInsets.only(bottom: 4),
                  child: SvgPicture.asset('img/y.svg', width: 24, height: 24),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    border: _selectedIndex == 3
                        ? Border(bottom: BorderSide(color: ColorsManager.dark, width: 2))
                        : null,
                  ),
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Image.asset('img/qq.png', width: 40, height: 40),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    border: _selectedIndex == 4
                        ? Border(bottom: BorderSide(color: ColorsManager.dark, width: 2))
                        : null,
                  ),
                  padding: const EdgeInsets.only(bottom: 4),
                  child: SvgPicture.asset('img/yy.svg', width: 24, height: 24),
                ),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.grey,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
