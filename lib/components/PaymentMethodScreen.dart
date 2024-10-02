// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import '../pages/payment/payment_result_screen.dart';

// void _handlePayPalPayment(BuildContext context) async {
//   final response = await http.post(
//     Uri.parse('http://192.168.8.126/php_traitement/paypal_payment/create_payment.php'),
//     body: {
//       'plan': plan,
//       'price': price.toString(),
//     },
//   );

//   if (response.statusCode == 200) {
//     final responseData = jsonDecode(response.body);
//     final approvalUrl = responseData['approval_url'];

//     // Open approval URL in a webview or browser
//     // Once payment is approved, handle the return to your app

//     // For now, simulate payment success
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PaymentResultScreen(success: true),
//       ),
//     );
//   } else {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PaymentResultScreen(success: false),
//       ),
//     );
//   }
// }
