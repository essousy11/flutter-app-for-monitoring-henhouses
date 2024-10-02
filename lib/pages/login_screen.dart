import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inscription/components/crud.dart';
import 'package:inscription/components/showmessage.dart';
import 'package:inscription/components/valid.dart';
import 'package:inscription/pages/home_page.dart';
import 'package:inscription/pages/reset_password/reset_password.dart';
import 'package:inscription/pages/change_password/verify_code_screen.dart';

import '../constant/linkapi.dart';
import '../main.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> formstate = GlobalKey();
  Crud crud = Crud();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  login() async {
  try {
    if (formstate.currentState!.validate()) {
      var response = await crud.postRequest(linkLogin, {
        "username": usernameController.text.trim(),
        "password": passwordController.text.trim(),
      });
      print(" this is ============> $response");
      if (response != null && response['status'] == "success") {

        //User user = User.fromJson(response['user']);
        // Check first connection status
        var firstConnectionResponse = await crud.checkFirstConnection(
          linkisFirst, 
          response['data']['user_id'], 
          response['data']['username'],
        );

        if (firstConnectionResponse != null && firstConnectionResponse['status'] == "success") {
          // Redirect to VerifyScreen
          //Navigator.of(context).pushNamedAndRemoveUntil("verify", (route) => false);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VerifyCodeScreen())
          );
          crud.sendVerificationCode(response['data']['username']);

        } else {
          // Redirect to HomeScreen
          //Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          //   MaterialPageRoute(builder: (context) => const HomeTest(user)),
          );
        }

        // Save user data to SharedPreferences
        // sharedPref.setString("id", user.userId.toString());
        await sharedPref.setString("user_id", response['data']['user_id']);
        await sharedPref.setString("username", response['data']['username']);
      } else {
        print("Login failed");
        // Handle login failure, show error message or update UI
        const Showmessage(title: "Login failed", message: "Your username or password is not correct",);
      
      }
    }
  } catch (e) {
    print("Error during login: $e");
    // Handle any exceptions during login process
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
              child: Form(
                key: formstate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/images/monitoring_icon.png', height: 150,),
                    SizedBox(height: 12.0),
                
                    // Text title
                    Text('SIGN IN',
                    style: GoogleFonts.robotoCondensed(
                      fontSize:40, fontWeight:FontWeight.bold),
                    ),
                    Text('welcome to ou app nice to see u !',
                    style: GoogleFonts.robotoCondensed(
                      fontSize:18),
                    ),
                    SizedBox(height: 20,),
                    // Username text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color : Colors.white,
                        borderRadius : BorderRadius.circular(12) ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:20),
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'username',
                            ),
                          ),
                          // child: TextFormField(
                          //     controller: usernameController,
                          //     decoration: InputDecoration(
                          //       hintText: 'username',
                          //       //border: InputBorder.none,
                          //       prefixIcon: Icon(Icons.person),
                          //       border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //       enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          //   validator: (val) {
                          //       return validInput(val.toString(), 2, 20);
                          //     },
                          //   ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    // Password filed
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color : Colors.white,
                        borderRadius : BorderRadius.circular(12) ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:20),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                          ),
                          // child: TextFormField(
                          //     controller: passwordController,
                          //     obscureText: true,
                          //     decoration: InputDecoration(
                          //       hintText: 'password',
                          //       border: InputBorder.none,
                          //       prefixIcon: Icon(Icons.password),
                          //       //border: OutlineInputBorder(),
                          //     ),
                          //     validator: (val) {
                          //       return validInput(val.toString(), 2, 12);
                          //     },
                          //   ),
                        ),
                      ),
                    ),
                
                    SizedBox(height: 15),
                
                    // Sign in button 
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:25),
                      child: 
  
                      GestureDetector(
                        onTap: () async {
                          await login();},
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.amber[900],
                            borderRadius: BorderRadius.circular(12) ),
                          child: Center(
                            child: Text('Log in',
                            style: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontWeight:FontWeight.bold,
                              fontSize :18,
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                
                    SizedBox(height: 25),
                
                    // Text Description
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[ 
                        Text(
                        'Not a member ?',
                        style: GoogleFonts.robotoCondensed(
                          fontWeight : FontWeight.bold,
                        ),
                      ),
                    
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                        );
                      },
                      child: Text(
                        'Forget password',
                        style: GoogleFonts.robotoCondensed(
                          color:Colors.green,
                          fontWeight : FontWeight.bold,
                        ),
                      ),
                    ),
                      ]
                    ),
                
                
                  ],
                ),
              ),
            ),
          ),
        ),
    );
      
  }
  }
