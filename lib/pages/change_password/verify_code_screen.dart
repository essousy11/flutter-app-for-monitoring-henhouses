import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inscription/components/crud.dart';
import 'package:inscription/components/showmessage.dart';

import '../../main.dart';
import '../login_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  
  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  Crud crud = Crud();
  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
  
  void verifyCode() async {
    String username = sharedPref.getString("username").toString(); // Replace with actual username (from state or storage)
    String verificationCode = _codeController.text.trim();

    var response = await crud.verifyCode(username, verificationCode);

    if (response['status'] == 'success') {
      // Handle verification success (e.g., navigate to another screen)
      print('Verification successful');
      Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false); // Navigate to home screen after verification
    } else {
      // Handle verification failure (e.g., show error message)
      print('Verification failed');
      // Optionally show an error message or update UI
      const Showmessage(title: "verify failed", message: "code erronée");
    }
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
                SizedBox(height: 20),

                // Code input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _codeController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Code',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Verify button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: verifyCode,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Verify',
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

                /////////////
                ///
                ///
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
                /////////
              ],
            ),
          ),
        ),
      ),
    );
  }
}
