import 'package:chat_app/ShoppingApp/Common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/Login/Controller/login_controller.dart';

class DrawerWidget extends StatefulWidget {
   DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          const UserAccountsDrawerHeader(
            accountName: Text(
              'Akash Vats',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text('akash.vats@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'A',
                style: TextStyle(fontSize: 24.0, color: Colors.blue),
              ),
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
          ),

          // Drawer Items
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Navigate to home or close the drawer
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Handle navigation to Profile screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Handle navigation to Settings screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              controller.signOut();

            },
          ),
        ],
      ),
    );
  }
}
