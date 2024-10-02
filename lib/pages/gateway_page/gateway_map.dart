import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:inscription/pages/henhouse_screens/henhouse_details.dart';

import '../../components/crud.dart';
import '../../constant/linkapi.dart';
import '../../main.dart';
import '../module_pages/module_page.dart';

class GatewayMap extends StatefulWidget {
  @override
  _GatewayMapState createState() => _GatewayMapState();
}

class _GatewayMapState extends State<GatewayMap> {
  GoogleMapController? mapController;
  List<Marker> markers = [];
  //Set<Marker> markers = {};
  Crud crud = Crud();

  @override
  void initState() {
    super.initState();
    getVilles();
  }

  void getVilles() async {
    try {
      String? userId = sharedPref.getString("user_id");
      if (userId != null) {
        var data = await crud.getVilles(linkListeVille, userId);
          if (data['status'] == 'success' && data['data'] != null) {
            var villeData = data['data'];
            print("this is  villeData ==>> $villeData");
            print("=================");
            print("this is  data['data] ===========> ${data['data']}");

            // Vérifiez si les données de la ville sont un tableau
            if (villeData is List) {
              for (var ville in villeData) {
                var cityName = ville['place'];
                var latitude = double.parse(ville['Latitude']);
                var longitude = double.parse(ville['longitude']);
                print("han $ville['place']");
                print("han $ville['Latitude']");
                print("han $ville['longitude']");


                markers.add(
                  Marker(
                    markerId: MarkerId(cityName),
                    position: LatLng(latitude, longitude),
                    infoWindow: InfoWindow(title: cityName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HenhouseDetails(place: cityName),
                        ),
                      );
                    },
                  ),
                  
                );
              }
              setState(() {
                markers;
                print("han markers =========> $markers");
              });
              
            } else {
              
              print('Les données de la ville ne sont pas au format attendu');
            }
          } else {
            print('Réponse de l\'API invalide');
          }
        } else {
          print('Échec de la requête : api erreur');
        }
      }
    catch (e) {
      print("Erreur : $e");
    }

    // Mettre à jour l'état pour reconstruire le widget avec les marqueurs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Gatways on Maps')),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Centre initial de la carte
          zoom: 2.0, // Zoom initial
        ),
        markers: Set<Marker>.of(markers), // Définir les marqueurs sur la carte
        //markers: markers,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
