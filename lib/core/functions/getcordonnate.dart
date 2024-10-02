import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant/linkapi.dart';
Future<LatLng?> getCoordinates(String city) async {
    const apiKey = 'your-google-maps-api';
    final apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=$city&key=$apiKey';

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['results'].length > 0) {
        var location = data['results'][0]['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      }
    }
    return null;
  }
  /// api key : AIzaSyARIIx6-9CcdfMZim9BwQtt_ifBrNgh_EA
