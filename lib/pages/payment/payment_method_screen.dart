// import 'package:flutter/material.dart';
// import 'payment_result_screen.dart';

// class PaymentMethodScreen extends StatelessWidget {
//   final String plan;
//   final String price;

//   PaymentMethodScreen({required this.plan, required this.price});

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Choose Payment Method'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             PaymentMethodOption(
//               title: 'Debit/Credit Card',
//               onTap: () {
//                 // Handle card payment logic
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PaymentResultScreen(success: true),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             PaymentMethodOption(
//               title: 'PayPal',
//               onTap: () {
//                 // Handle PayPal payment logic
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PaymentResultScreen(success: true),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             PaymentMethodOption(
//               title: 'Stripe',
//               onTap: () {
//                 // Handle Stripe payment logic
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PaymentResultScreen(success: true),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PaymentMethodOption extends StatelessWidget {
//   final String title;
//   final VoidCallback onTap;

//   PaymentMethodOption({required this.title, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         child: ListTile(
//           title: Text(title),
//         ),
//       ),
//     );
//   }
// }




