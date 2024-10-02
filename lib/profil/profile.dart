import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inscription/components/showmessage.dart';
import 'package:inscription/constant/linkapi.dart';
import 'package:inscription/pages/home_page.dart';

import '../../components/crud.dart';
import '../../main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  Crud crud = Crud();

  updateProfile() async {
    // Implement your update logic her
    String? userId = sharedPref.getString("user_id");
    var response = await crud.UpdateProfile(linkProfileUpdate, userId!, nameController.text, emailController.text, telephoneController.text, addressController.text);
        
    if (response['status'] == "success"){
      print("infos changed succefully");
      //const ShowMessage(title: "Profile Edited", message: "Your infos are successfully changed");
      showDialog(
        context: context,
        builder: (context) => const Showmessage(
          title: "Profile Edited",
          message: "Your infos are successfully changed",
        ),
      );
      
    }else{
      print("there is an error");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        leading: IconButton(onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => const HomePage())
                                            ), 
        icon: const Icon(Icons.arrow_back_ios)),

      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: telephoneController,
                          decoration: InputDecoration(
                            labelText: 'Telephone',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your telephone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     if (formKey.currentState!.validate()) {
                        //       // Perform update logic here
                        //       updateProfile();
                        //     }
                        //   },
                        //   child: Text('Update'),
                        // ),
                        // update button start
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal:25),
                      child: GestureDetector(
                        onTap: (){
                          if (formKey.currentState!.validate()){
                            updateProfile();
                            //const ShowMessage(title: 'Profile Edited', message: 'Your infos are successfully changed');
                          }
                          //const ShowMessage(title: 'Profile Edited', message: 'Your infos are successfully changed');
                          
                          },

                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.amber[900],
                            borderRadius: BorderRadius.circular(12) ),
                          child: Center(
                            child: Text('Update',
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

                        // End update button
                      ],
                    ),
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
