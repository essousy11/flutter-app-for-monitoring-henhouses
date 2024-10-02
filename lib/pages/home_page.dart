import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inscription/components/showmessage.dart';
import 'package:inscription/components/sidebarAccount.dart';
import 'package:inscription/components/sidebar_menu.dart';
import 'package:inscription/pages/gateway_page/gateway_map.dart';
import 'package:inscription/pages/henhouse_screens/henhouse_details.dart';
import 'package:inscription/pages/module_pages/module_page.dart';
import 'package:barcode_scan2/barcode_scan2.dart'; // Add barcode_scan2 package

import '../components/card_info/card_info_gateway.dart';
import '../components/crud.dart';
import '../constant/linkapi.dart';
import '../core/functions/getcordonnate.dart';
import '../main.dart';




class HomePage extends StatefulWidget {
  
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List data = [];
  Crud crud= new Crud();
  
  List<Map<String, dynamic>> cardData = []; // Changed to List<Map<String, dynamic>>

  GoogleMapController? mapController;
  List<Marker> markers = [];

  String userName= "Loading..."; //= sharedPref.getString("username");
  
  @override
  void initState() {
    super.initState();
    userDataCard();
    //getVilles();
    userName = (sharedPref.getString('username') ?? 'Unknown User');
    //userId = (sharedPref.getString("user_id")?? 'unknown userId');
  }

  // getVilles() async{

  //   try{
  //     String? userId = sharedPref.getString("user_id");
  //     if (userId != null) {
  //       var villes = await crud.getVilles(linkHomeCard, userId);
        
  //       if (villes['status'] == 'success') {
  //         if (villes != null && villes is List) {
  //           // Parcourir la liste des villes et obtenir les coordonnées via l'API de géocodage de Google
  //           for (var ville in villes) {
  //             var coordinates = await getCoordinates(ville['name']);
  //             if (coordinates != null) {
  //               markers.add(
  //                 Marker(
  //                   markerId: MarkerId(ville['name']),
  //                   position: coordinates,
  //                   infoWindow: InfoWindow(title: ville['name']),
  //                 ),
  //               );
  //             }
  //           }
  //         } else {
  //           print('Réponse de l\'API invalide');
  //         }
  //       } else {
  //         print('Échec de la requête : api failed');
  //       }
  //     }
  //   } catch (e) {
  //     print("Erreur : $e");
  //   }

  //   // Mettre à jour l'état pour reconstruire le widget avec les marqueurs
  //   setState(() {});
  // }
        ///////////////////////////////////////////////// End get ville function ///////////////::
  userDataCard() async {
    try {
      String? userId = sharedPref.getString("user_id");
      print("User ID: $userId");

      if (userId != null) {
        var userDataCardResponse = await crud.userHomeCard(linkHomeCard, userId);

        setState(() {
          if (userDataCardResponse['status'] == "success") {
            cardData = List<Map<String, dynamic>>.from(userDataCardResponse['data']); // Assign data directly
            print("han cardData =====> $cardData");
          } else {
            cardData = []; // Handle if no data or error
          }
        });
      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  updateGateway( String moduleGtwId, String sim, String gwtId) async {
    String? userId = sharedPref.getString("user_id");
   if (userId != null) {
        var updateGatewayData = await crud.updateGateway(userId, moduleGtwId, sim, gwtId);
        if (updateGatewayData['status'] == "success"){
          //return const AlertDialog(
          showDialog(
              context: context,
              builder: (BuildContext context) {
            return const Showmessage(title: 'Update Gateway', message: 'Votre gateway infos sont modifié');
        }
        );
          //);
        }
        else showDialog(
              context: context,
              builder: (BuildContext context) {
        return const Showmessage(title: 'Update Gateway', message: 'Votre gateway infos sont pas correct');
              }
        );
  }
  else showDialog(
              context: context,
              builder: (BuildContext context) {
  return const Showmessage(title: 'Update Gateway', message: 'Votre gateway infos sont pas correct');
              }
  );
  }
  //////// show add gateway screen //////////////
 TextEditingController gatewayIdController = TextEditingController();
  TextEditingController simController = TextEditingController();
  TextEditingController moduleGtwIdController = TextEditingController();

  Future<void> _showAddGatewayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Gateway'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: gatewayIdController,
                  decoration: const InputDecoration(hintText: "Enter Gateway ID"),
                ),
                
                TextField(
                  controller: moduleGtwIdController,
                  decoration: const InputDecoration(hintText: "Enter Module Gateway ID"),
                ),
                TextField(
                  controller: simController,
                  decoration: const InputDecoration(hintText: "Enter Numero Sim"),
                ),
                
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('update'),
              onPressed: () {
                updateGateway(moduleGtwIdController.text, simController.text, gatewayIdController.text);
               
              },
            ),
          ],
        );
      },
    );
  }
  
  ////////// End fnction add gateway ///////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title:  Center(child: Text(userName)),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              //_scaffoldKey.currentState?.openEndDrawer();
              //getVilles();
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GatewayMap()),
            );

            },
          ),

          // IconButton(
          //   icon: const Icon(Icons.add),
          //   onPressed: _showAddGatewayDialog,
          // ),
        ],
      ),
      drawer: SidebarMenu(),
      endDrawer: const SidebarAccount(),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: cardData.isNotEmpty ?
        ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: cardData.length,
          itemBuilder: (context, index){
          var item = cardData[index];
          return CardInfoGateway(
                    city: item['place'].toString(),
                    weight: double.parse(item['total_weight']), // Assuming total_weight is numeric
                    henhouseNumber: int.parse(item['nb_henhouse']),
                    gwtId: item['gwt_id'].toString(),
                    onTap: () {
                      // Handle tap if needed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //builder: (context) => ModulePage(place: item['place'].toString()),
                          builder: (context) => HenhouseDetails(place: item['place'].toString()),
                        ),
                      );
                    },
                    
                  );
                  
                },
              )
            : cardData.isEmpty
                ? const Center (child: CircularProgressIndicator())
                : const Center(child: Text('No data found')),
            ),

            floatingActionButton: FloatingActionButton(
            onPressed: _showAddGatewayDialog,
            tooltip: 'Increment',
            child: const Icon(Icons.update),
          ),
            
        
        
          );
          }
}


