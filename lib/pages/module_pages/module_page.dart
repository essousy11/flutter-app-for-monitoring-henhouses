// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:inscription/components/card_info/card_info_module.dart';
// import 'package:inscription/components/sidebarAccount.dart';
// import 'package:inscription/components/sidebar_menu.dart';
// import 'package:inscription/pages/module_pages/module_details.dart';


// import '../../components/crud.dart';
// import '../../constant/linkapi.dart';
// import '../../main.dart';




// class ModulePage extends StatefulWidget {
//   final String place;

//   const ModulePage({Key? key, required this.place}) : super(key: key);

//   @override
//   _ModulePageState createState() => _ModulePageState();
// }

// class _ModulePageState extends State<ModulePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   Crud crud= new Crud();
  
//   List<Map<String, dynamic>> cardData = []; // Changed to List<Map<String, dynamic>>

//   String userName= "Loading..."; //= sharedPref.getString("username");

//   @override
//   void initState() {
//     super.initState();
//     userDataCard();
//     userName = (sharedPref.getString('username') ?? 'Unknown User');
//   }

//   userDataCard() async {
//     try {
//       String? userId = sharedPref.getString("user_id");
//       print("User ID: $userId");

//       if (userId != null) {
//         var userDataCardResponse = await crud.userModuleCard(linkModuleCard, userId, widget.place);

//         setState(() {
//           if (userDataCardResponse['status'] == "success") {
//             cardData = List<Map<String, dynamic>>.from(userDataCardResponse['data']); // Assign data directly
//             print("han cardData =====> $cardData");
//           } else {
//             cardData = []; // Handle if no data or error
//           }
//         });
//       } else {
//         print("User ID is null");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return 
//     Scaffold(
//        key: _scaffoldKey,
//       appBar: AppBar(
//         title: Center(child: Text(userName)),
//         leading: IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.person),
//             onPressed: () {
//               _scaffoldKey.currentState?.openEndDrawer();
//             },
//           ),
//         ],
//       ),
//       drawer: const SidebarMenu(),
//       endDrawer: const SidebarAccount(),
//       body:
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: cardData.isNotEmpty ?
//         ListView.builder(
//           padding: const EdgeInsets.only(top: 20),
//           itemCount: cardData.length,
//           itemBuilder: (context, index){
//           var item = cardData[index];
//           return CardInfoModule(
//                     type: item['type'].toString(),
//                     weight: double.parse(item['weight']), // Assuming total_weight is numeric
//                     moduleGwtId: item['module_gtw_id'].toString(),
//                     nowDate: item['date'],
//                     onTap: () {
//                       // Handle tap if needed
//                       Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) =>  ModuleDetails()),
//                     );
//                     },
                    
//                   );
                  
//                 },
//               )
//             : cardData.isEmpty
//                 ? const Center (child: CircularProgressIndicator())
//                 : const Center(child: Text('No data found')),
//             ),
        
        
        
//           );
//           }
// }
          
    