import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inscription/pages/login_screen.dart';
import 'package:inscription/pages/reset_password/verify_reset.dart';
import 'package:inscription/pages/change_password/verify_code_screen.dart';
import '../../components/crud.dart';
import '../../main.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String userName = ''; 
  Crud crud = Crud(); // Initialize your CRUD class instance here

  // @override
  // void dispose() {
  //   username.dispose();
  //   newPasswordController.dispose();
  //   confirmPasswordController.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  sendCode (){
    String userName = username.text.trim();
    crud.sendVerificationCode(userName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/images/monitoring_icon.png', height: 150),
                const SizedBox(height: 20),

                // Old Password input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: username,
                        //obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'username',
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // New Password input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: newPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'New Password',
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Confirm Password input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Change Password button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap:(){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerifyResetCodeScreen(username: username.text, newpassword: newPasswordController.text , confirmpassword: confirmPasswordController.text)),
                    );
                    sendCode();
                    }, // Call changePassword method on tap
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Reset Password',
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Change Password button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        'Back to login',
                        style: GoogleFonts.robotoCondensed(
                          color:Colors.black,
                          fontWeight : FontWeight.bold,
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


