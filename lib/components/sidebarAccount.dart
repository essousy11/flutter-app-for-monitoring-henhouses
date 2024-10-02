import 'package:flutter/material.dart';

import '../main.dart';
import 'sidebar_items.dart';

class SidebarAccount extends StatefulWidget {
  const SidebarAccount({super.key});

  @override
  State<SidebarAccount> createState() => _SidebarAccountState();
}

class _SidebarAccountState extends State<SidebarAccount> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: Colors.amber[200],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.amber[900],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   radius: 30.0,
                    //   backgroundImage: AssetImage('assets/profile.jpg'),
                    // ),
                    // SizedBox(height: 10.0),
                    // Text(
                    //   'Profile',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 24,
                    //   ),
                    // ),
                  ],
                ),
              ),
              createDrawerItem(
                icon: Icons.edit,
                text: 'Edit Profile',
                onTap: () => Navigator.pop(context),
              ),
              createDrawerItem(
                icon: Icons.logout,
                text: 'Sign Out',
                onTap: () {
                  // Perform sign out logic
                   sharedPref.clear();
                   Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
                  //Navigator.pop(context); // Close drawer after sign-out
                },
              ),
            ],
          ),
        ),
      );
  }
}