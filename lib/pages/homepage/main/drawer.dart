import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //_buildUserHeader(),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Tindakan saat item 1 dipilih
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Tindakan saat item 2 dipilih
            },
          ),
        ],
      ),
    );
  }
/* 
  void _handleLogout(BuildContext context) {
    saveLoginStatus(false);

    Get.off(() => const DashboardMain(), binding: MainBinding());
  } */
}
