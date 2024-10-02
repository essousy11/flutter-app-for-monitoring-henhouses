import 'package:flutter/material.dart';
import 'package:inscription/components/sidebar_items.dart';
import 'package:inscription/pages/payment/plan_selection_screen.dart';

import '../main.dart';
import '../profil/profile.dart';

class SidebarMenu extends StatefulWidget {
  SidebarMenu({super.key});

  
  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  String userName= "Loading..."; //= sharedPref.getString("username");
  @override
  void initState() {
    super.initState();
    //getVilles();
    userName = (sharedPref.getString('username') ?? 'Unknown User');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          //color: Colors.amber[200],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   radius: 30.0,
                    //   //backgroundImage: AssetImage('images/profile.jpg'),
                    // ),
                    SizedBox(height: 10.0),
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              createDrawerItem(
                icon: Icons.home,
                text: 'Home',
                onTap: () => Navigator.pop(context),
              ),
              //Harvest / Device /Inspection / language / Sign out / info perso / About
              createDrawerItem(
                icon: Icons.category,
                text: 'Harvest',
                onTap: () => Navigator.pop(context),
              ),
              createDrawerItem(
                icon: Icons.local_offer,
                text: 'Inspection',
                onTap: () => Navigator.pop(context),
              ),
              createDrawerItem(
                icon: Icons.star,
                text: 'Language',
                onTap: () => Navigator.pop(context),
              ),
              createDrawerItem(
                icon: Icons.star,
                text: 'Info Perso',
                onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Profile())
                            ),
              ),
              createDrawerItem(
                icon: Icons.star,
                text: 'Subscription',
                // onTap: () => Navigator.push(
                //               context,
                //               MaterialPageRoute(builder: (context) => PlanSelectionScreen())
                //             ),
                onTap: () => {}
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