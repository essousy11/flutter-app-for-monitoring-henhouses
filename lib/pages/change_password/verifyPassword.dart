import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inscription/pages/login_screen.dart';
import '../../components/crud.dart';
import '../../main.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  Crud crud = Crud(); // Initialize your CRUD class instance here

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void changePassword() async {
    try {
      // Validate form fields
      if (_oldPasswordController.text.isEmpty ||
          _newPasswordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty) {
        print('All fields are required');
        return;
      }

      // Validate new password and confirm password
      if (_newPasswordController.text != _confirmPasswordController.text) {
        print('New passwords do not match');
        return;
      }

      // Replace with your logic to get user ID
      String? userIdString = sharedPref.getString('user_id'); // Retrieve as String
      // Handle case where user ID is not found or not parsable
        if (userIdString == null) {
          print('User ID not found in SharedPreferences');
          return; // Or handle this case as per your app's logic
        }
        int userId = int.parse(userIdString);
      // int userId = sharedPref.getInt('id') ?? 0; // Example: Replace with actual user ID logic (from state or storage)
      //   if (userId == null) {
      //   print('User ID not found in SharedPreferences');
      //   return;
      // }
      // Call CRUD method to change password
      var response = await crud.changePassword(
        userId,
        _oldPasswordController.text,
        _newPasswordController.text,
      );

      // Handle response from CRUD operation
      if (response['status'] == 'success') {
        // Password changed successfully
        print('Password changed successfully');
        Navigator.of(context).pushNamedAndRemoveUntil("verifycode", (route) => false);
        // Optionally show success message or navigate to another screen
        // Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        // Handle password change failure
        print('Password change failed: ${response['message']}');
        // Optionally show an error message to the user
      }
    } catch (e) {
      print('Exception during change password: $e');
      // Handle any exceptions that occur during the process
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _oldPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Old Password',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // New Password input field
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
                        controller: _newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'New Password',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Confirm Password input field
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
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Change Password button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: changePassword, // Call changePassword method on tap
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Change Password',
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

                SizedBox(height: 20),

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


