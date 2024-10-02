// import 'package:flutter/material.dart';

// class PaymentResultScreen extends StatelessWidget {
//   final bool success;

//   PaymentResultScreen({required this.success});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(success ? 'Payment Successful' : 'Payment Failed'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               success ? Icons.check_circle : Icons.error,
//               color: success ? Colors.green : Colors.red,
//               size: 100,
//             ),
//             SizedBox(height: 20),
//             Text(
//               success ? 'Your payment was successful!' : 'Your payment failed.',
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.popUntil(context, (route) => route.isFirst);
//               },
//               child: Text('Back to Home'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// Flutter code for payment success page
// import 'package:flutter/material.dart';

// class PaymentSuccessPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Payment Success')),
//       body: Center(
//         child: Text('Payment was successful!'),
//       ),
//     );
//   }
// }
