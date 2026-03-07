import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/features/chats/shats.dart';
import 'package:sada/features/events/events.dart';
import 'package:sada/features/home/screen/home.dart';
import 'package:sada/features/serach/serach.dart';
import 'package:sada/features/setting/screens/setting.dart';
import 'package:sada/features/sustainability/sustainability_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    // const SustainabilityScreen(),
    const SustainabilityScreen(),
    const Serach(),
    const Shats(),
    const Events(),
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
      appBar: _selectedIndex == 3 ? null : AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('img/logo.png', width: 100, height: 100, fit: BoxFit.cover),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: ColorsManager.kPrimaryColo, borderRadius: BorderRadius.circular(24)),
                child: Icon(Icons.person, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.notification_add_outlined)),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorsManager.lighterGrayBottom,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, -4),
            ),
          ],
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
                  child: Image.asset('img/qq.png', width: 40, height: 40,
                    fit: BoxFit.cover,),
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
