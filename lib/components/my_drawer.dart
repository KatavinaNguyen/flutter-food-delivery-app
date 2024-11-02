import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_drawer_tile.dart';
import 'package:food_delivery_app/services/auth/auth_services.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(BuildContext context) async {
    final authService = AuthService();
    await authService.signOut();
    Navigator.popUntil(
        context,
        (route) => route
            .isFirst); // Navigate to the home screen or login screen after logout
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService().getCurrentUser(); // Get the current user
    final customerId = user?.uid ?? ''; // Get the customer ID

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // app logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset(
              'lib/images/logo/Yum_Yum_Logo.PNG',
              width: 150,
              height: 150,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // home list tile
          MyDrawerTile(
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
            text: "H O M E",
          ),

          // settings list tile
          MyDrawerTile(
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ));
            },
            text: "S E T T I N G S",
          ),

          const Spacer(),

          // logout list tile
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              logout(context);
              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
