import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'home_page.dart';
import 'login_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 10), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // big logo
            Padding(
              padding: const EdgeInsets.only(
                left: 100.0,
                right: 100.0,
                top: 120,
                bottom: 20,
              ),
              child: Center(child: Image.asset('lib/images/monitoring_icon.png')),
            ),

            
            // groceree gives you fresh vegetables and fruits
          //   Text(
          //     'Fresh items everyday',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontSize: 16,
          //       color: Colors.grey[700],
          //     ),
          //   ),

          //   const SizedBox(height: 24),

          //   const Spacer(),

          //   // get started button
          //   GestureDetector(
          //     onTap: () => Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return HomePage();
          //         },
          //       ),
          //     ),
          //     child: Container(
          //       padding: const EdgeInsets.all(24),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(16),
          //         color: const Color.fromARGB(255, 112, 91, 222),
          //       ),
          //       child: const Text(
          //         "Get Started",
          //         style: TextStyle(
          //           color: Colors.white,
          //           // fontWeight: FontWeight.bold,
          //           fontSize: 16,
          //         ),
          //       ),
          //     ),
          //   ),

          //   const Spacer(),
          ],
        ),
      ),
    );
  }
}