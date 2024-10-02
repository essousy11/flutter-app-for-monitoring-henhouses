

// import 'dart:ffi';

// import 'package:flutter/material.dart';

// import '../../components/crud.dart';
// import 'payment_method_screen.dart';

// class PlanSelectionScreen extends StatefulWidget {
//   const PlanSelectionScreen({super.key});

//   @override
//   State<PlanSelectionScreen> createState() => _PlanSelectionScreenState();
// }

// class _PlanSelectionScreenState extends State<PlanSelectionScreen> {
//   @override
//   Crud crud = Crud();
//   List planData = [];

  
//   Future<void> planPrice() async {
//   try {
//     var planPriceData = await crud.planPrice();

//     // Check if planPriceData is not null and has the 'status' key
//     if (planPriceData != null && planPriceData['status'] == "success") {
//       // Safely handle 'data' if it exists and is a List
//       if (planPriceData['data'] is List) {
//         planData = List<Map<String, dynamic>>.from(planPriceData['data']);
//       } else {
//         planData = [];
//       }
//       print("Plan Data: $planData");
//       print (planData[0]['price_9']);
//     } else {
//       // Handle the case where status is not "success" or 'data' is missing
//       planData = [];
//       print("No data or error in response: ${planPriceData?['message'] ?? 'Unknown error'}");
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }

//   @override
//   void initState() {
//     super.initState();
//     planPrice();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Choose a Plan'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
          
//           //padding: const EdgeInsets.only(top: 20),
//           itemCount: planData.length,
//           itemBuilder: (context, index){
//           var item = planData[index];
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               PlanOption(
//                 title: '9 Months',
//                 price: item['price_9'],
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PaymentMethodScreen(plan: '9 Months', price: item['price_9']),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//               PlanOption(
//                 title: '12 Months',
//                 price: item['price_12'],
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PaymentMethodScreen(plan: '12 Months', price: item['price_12']),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           );
//           }
//         ),
//       ),
//     );
//   }
// }

// class PlanOption extends StatelessWidget {
//   final String title;
//   final String price;
//   final VoidCallback onTap;

//   PlanOption({required this.title, required this.price, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         child: ListTile(
//           title: Text(title),
//           subtitle: Text('$price'),
//         ),
//       ),
//     );
//   }
// }