import 'dart:core';

import 'package:flutter/material.dart';

// class ShowMessage extends StatelessWidget {
//   final String title;
//   final String message;
//   //final Function() confirmButton;
//   const ShowMessage({super.key, required this.title, required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(

//             title: Text(title),

//             content: Text(message),

//             actions: <Widget>[

//               TextButton(

//                 child: const Text('OK'),

//                 onPressed: () {

//                   Navigator.of(context).pop();

//                 },

//               ),

//               // TextButton(

//               //   child: const Text('Confirm'),

//               //   onPressed: () {

//               //     // Handle the confirm action
//               //     confirmButton;

//               //   },

//               // ),

//             ],

//           );
//   }
// }


class Showmessage extends StatefulWidget {
  final String title;
  final String message;
  const Showmessage({super.key, required this.title, required this.message});

  @override
  State<Showmessage> createState() => _ShowmessageState();
}

class _ShowmessageState extends State<Showmessage> {
    @override
  Widget build(BuildContext context) {
    return AlertDialog(

            title: Text(widget.title),

            content: Text(widget.message),

            actions: <Widget>[

              TextButton(

                child: const Text('OK'),

                onPressed: () {

                  Navigator.of(context).pop();

                },

              ),

              // TextButton(

              //   child: const Text('Confirm'),

              //   onPressed: () {

              //     // Handle the confirm action
              //     confirmButton;

              //   },

              // ),

            ],

          );
  }
}