import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constant/app_color.dart';
import '../../views/screens/feeds_page.dart';
import '../../views/screens/home_page.dart';
import '../../views/screens/notification_page.dart';
import '../../views/screens/profile_page.dart';

class PageSwitcher extends StatefulWidget {
  const PageSwitcher({super.key});

  @override
  State<PageSwitcher> createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomePage(),
        const FeedsPage(),
        const NotificationPage(),
        const ProfilePage(),
      ][_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColor.primarySoft, width: 2))),
        child: BottomNavigationBar(
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            (_selectedIndex == 0) ? BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/Home-active.svg'), label: '') : BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/Home.svg'), label: ''),
            (_selectedIndex == 1) ? BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/Category-active.svg'), label: '') : BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/Category.svg'), label: ''),
            (_selectedIndex == 2) ? BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/Notification-active.svg'), label: '') : BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/Notification.svg'), label: ''),
            (_selectedIndex == 3) ? BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/Profile-active.svg'), label: '') : BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/Profile.svg'), label: ''),
          ],
        ),
      ),
    );
  }
}
