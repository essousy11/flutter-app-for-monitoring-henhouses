import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsTest extends StatefulWidget {
  @override
  _MapsTestState createState() => _MapsTestState();
}

class _MapsTestState extends State<MapsTest> {
  GoogleMapController? mapController;
  Set<Marker> markers = {}; // Utilisation d'un Set pour les marqueurs

  @override
  void initState() {
    super.initState();
    addStaticMarkers();
  }

  void addStaticMarkers() {
    Set<Marker> newMarkers = {
      Marker(
        markerId: MarkerId('Paris'),
        position: LatLng(48.8566, 2.3522),
        infoWindow: InfoWindow(title: 'Paris'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DummyModulePage(place: 'Paris'),
            ),
          );
        },
      ),
      Marker(
        markerId: MarkerId('New York'),
        position: LatLng(40.7128, -74.0060),
        infoWindow: InfoWindow(title: 'New York'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DummyModulePage(place: 'New York'),
            ),
          );
        },
      ),
      Marker(
        markerId: MarkerId('Tokyo'),
        position: LatLng(35.6895, 139.6917),
        infoWindow: InfoWindow(title: 'Tokyo'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DummyModulePage(place: 'Tokyo'),
            ),
          );
        },
      ),
    };

    setState(() {
      markers = newMarkers; // Mettre à jour les marqueurs
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Gateways on Maps')),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Centre initial de la carte
          zoom: 2.0, // Zoom initial
        ),
        markers: markers, // Définir les marqueurs sur la carte
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}

class DummyModulePage extends StatelessWidget {
  final String place;

  DummyModulePage({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Module Page'),
      ),
      body: Center(
        child: Text('Welcome to $place'),
      ),
    );
  }
}
