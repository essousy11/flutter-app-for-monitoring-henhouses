import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inscription/pages/gateway_page/gateway_map.dart';
import 'package:inscription/pages/home_page.dart';
import 'package:inscription/pages/home_screen.dart';
import 'package:inscription/pages/login_screen.dart';
import 'package:inscription/pages/reset_password/reset_password.dart';
import 'package:inscription/pages/change_password/verify_code_screen.dart';
import 'package:inscription/pages/test_screens/module_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/animation.dart';
//import 'authentification.dart';
import 'functions/localisation.dart';
import 'pages/change_password/verifyPassword.dart';
import 'pages/henhouse_screens/henhouse_details.dart';
import 'pages/henhouse_screens/chart_screen.dart';
import 'pages/henhouse_screens/preview_screen.dart';
import 'pages/maps_test.dart';
import 'pages/payment/plan_selection_screen.dart';
//import 'package:provider/provider.dart';
late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      //home: AuthenticationScreen(),
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        //primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18), // Utilisation de bodyMedium
        ),
      ),
        //home: const HomePage(),
        //home: const ResetPasswordScreen(),
        //initialBinding :Initialbindings(),
      //   initialRoute: sharedPref.getString("user_id") == null ? "login" : "home",
      //   routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   'login': (context) => const LoginScreen(),
      //   'home': (context) => const HomePage(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   //'/': (context) => IntroScreen(),
      //   'resetpass': (context) => const ResetPasswordScreen(),
      //   'verifycode': (context) => const VerifyCodeScreen(),
      //   'verifypass': (context) => const ChangePasswordScreen(),
      //   'gatewaymap': (context) =>  GatewayMap(),

      // },
      
      home: const HomeScreen(),
      
    );
    }
}






