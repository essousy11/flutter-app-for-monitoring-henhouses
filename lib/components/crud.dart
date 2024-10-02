import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inscription/constant/linkapi.dart';

class Crud {

  Future<dynamic> getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody; // Retourne les données décodées si la requête est réussie
      } else {
        print("Error ${response.statusCode}");
        return null; // Ou une autre logique de gestion des erreurs selon votre besoin
      }
    } catch (e) {
      print("Error Catch $e");
      return null; // Gérer les erreurs d'une manière appropriée
    }
  }


   Future<dynamic> postRequest(String url, Map<String, dynamic> data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        //User user = User.fromJson(responsebody['user']);
        print("hat respnse body n crud aya Response Status Code: $responsebody");
        // List<dynamic> jsonResponse = jsonDecode(response.body);
        return responsebody; // Retourne les données décodées si la requête est réussie
      } else {
        print("Error ${response.statusCode}");
        return null; // Ou une autre logique de gestion des erreurs selon votre besoin
      }
    } catch (e) {
      print("Error Catch $e");
      return null; // Gérer les erreurs d'une manière appropriée
    }
  }

  Future<Map<String, dynamic>?> checkFirstConnection(String url, String userId, String username) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: {
            'user_id': userId,
            'username': username,
          });

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error Catch $e");
      return null;
    }
  }


  Future<void> sendVerificationCode(String username) async {
    try {
      var response = await http.post(Uri.parse(linkSend), body: {
        'username': username,
      });

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        return responseData;
        } else {
          print('Failed to send verification code');
          // Handle failure to send verification code
        }
    } catch (e) {
      print('Error sending verification code: $e');
      // Handle other errors (network, parsing, etc.)
    }
  }

  Future<Map<String, dynamic>> verifyCode(String username, String verifyCode) async {
    try {
      // Construct the URL for the verify_code.php endpoint
      Uri url = Uri.parse(linkVerify);

      // Send POST request with username and verification code
      var response = await http.post(
        url,
        body: {
          'username': username,
          'verify_code': verifyCode,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('Failed to verify code. Error ${response.statusCode}');
        return {'status': 'fail'};
      }
    } catch (e) {
      print('Error verifying code: $e');
      return {'status': 'fail'};
    }
  }
  Future<Map<String, dynamic>> changePassword(int userId, String oldPassword, String newPassword) async {
    try {
      var url = Uri.parse(linkChange);
      var response = await http.post(
        url,
        body: {
          'user_id': userId,
          'oldpassword': oldPassword,
          'newpassword': newPassword,
          // Assuming you have a 'confirmpassword' field in your PHP script,
          // you should also include it here if required by your backend.
          'confirmpassword': newPassword,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('HTTP Error ${response.statusCode}');
        return {'status': 'error', 'message': 'HTTP Error ${response.statusCode}'};
      }
    } catch (e) {
      print('Exception during changePassword: $e');
      return {'status': 'error', 'message': 'Exception: $e'};
    }
  }

  Future<Map<String, dynamic>> resetPassword(String username, String newPassword, String confirmpassword, String verifyCode) async {
    try {
      var url = Uri.parse(linkResetPass);
      var response = await http.post(
        url,
        body: {
          'username': username,
          'newpassword': newPassword,
          'verify_code': verifyCode,
          'confirmpassword': confirmpassword,
          // Assuming you have a 'confirmpassword' field in your PHP script,
          // you should also include it here if required by your backend.
        },
      );

      if (response.statusCode == 200) {
        
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('HTTP Error ${response.statusCode}');
        return {'status': 'error', 'message': 'HTTP Error ${response.statusCode}'};
      }
    } catch (e) {
      print('Exception during changePassword: $e');
      return {'status': 'error', 'message': 'Exception: $e'};
    }
  }


Future<Map<String, dynamic>> userHomeCard(String url, String? userId) async {
    try {
      //var url = Uri.parse(linkHomeCard);
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId ??'',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('HTTP Error ${response.statusCode}');
        return {'status': 'error', 'message': 'HTTP Error ${response.statusCode}'};
      }
    } catch (e) {
      print('Exception during changePassword: $e');
      return {'status': 'error', 'message': 'Exception: $e'};
    }
  }


  Future<Map<String, dynamic>> userModuleCard(String url, String? userId, String place) async {
    try {
      //var url = Uri.parse(linkHomeCard);
      var response = await http.post(
        Uri.parse(url),
        body: {
          'user_id': userId ??'',
          'place': place,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('HTTP Error ${response.statusCode}');
        return {'status': 'error', 'message': 'HTTP Error ${response.statusCode}'};
      }
    } catch (e) {
      print('Exception during changePassword: $e');
      return {'status': 'error', 'message': 'Exception: $e'};
    }
  }


Future<dynamic> getVilles(String url, String userId) async {
    try {
      var response = await http.post(
        Uri.parse(url), 
        body: {
          'user_id': userId ??'',
        },
        );
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        //User user = User.fromJson(responsebody['user']);
        print("hat respnse body n crud aya Response Status Code: $responsebody");
        // List<dynamic> jsonResponse = jsonDecode(response.body);
        return responsebody; // Retourne les données décodées si la requête est réussie
      } else {
        print("Error ${response.statusCode}");
        return null; // Ou une autre logique de gestion des erreurs selon votre besoin
      }
    } catch (e) {
      print("Error Catch $e");
      return null; // Gérer les erreurs d'une manière appropriée
    }
  }



////////// Start Chart  Data /////////////////////

Future<dynamic> getChartData(String url, String userId, String startDate, String endDate) async {
    try {
      var response = await http.post(
        Uri.parse(url), 
        body: {
          'user_id': userId ??'',
          'start_date': startDate,
          'end_date': endDate,
        },
        );
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        //User user = User.fromJson(responsebody['user']);
        print("this is Response Status Code: $responsebody");
        // List<dynamic> jsonResponse = jsonDecode(response.body);
        return responsebody; // Retourne les données décodées si la requête est réussie
      } else {
        print("Error ${response.statusCode}");
        return null; // Ou une autre logique de gestion des erreurs selon votre besoin
      }
    } catch (e) {
      print("Error Catch $e");
      return null; // Gérer les erreurs d'une manière appropriée
    }
  }
////////// End Chart Data //////////////////////////


  //////// Start of Profile Updating Infos ///////////

Future<dynamic> UpdateProfile(String url, String userId, String name, String email, String phone, String address) async {
    try {
      var response = await http.post(
        Uri.parse(url), 
        body: {
          'user_id': userId ??'',
          'name': name ,
          'email': email,
          'N_telephone': phone ,
          'address': address ,
        },
        );
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        //User user = User.fromJson(responsebody['user']);
        print("this is Response Status Code of update profile: $responsebody");
        // List<dynamic> jsonResponse = jsonDecode(response.body);
        return responsebody; // Retourne les données décodées si la requête est réussie
      } else {
        print("Error ${response.statusCode}");
        return null; // Ou une autre logique de gestion des erreurs selon votre besoin
      }
    } catch (e) {
      print("Error Catch $e");
      return null; // Gérer les erreurs d'une manière appropriée
    }
  }



//////// End  of Profile Updating Infos ///////////
///////// Start Box Data  ////////////////////////

Future<dynamic> getBoxData(String url, String userId, String moduleGtwId) async {
    try {
      var response = await http.post(
        Uri.parse(url), 
        body: {
          'user_id': userId ??'',
          'module_gtw_id': moduleGtwId,
        },
        );
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        //User user = User.fromJson(responsebody['user']);
        print("this is Response Status Code of box data: $responsebody");
        // List<dynamic> jsonResponse = jsonDecode(response.body);
        return responsebody; // Retourne les données décodées si la requête est réussie
      } else {
        print("Error ${response.statusCode}");
        return null; // Ou une autre logique de gestion des erreurs selon votre besoin
      }
    } catch (e) {
      print("Error Catch $e");
      return null; // Gérer les erreurs d'une manière appropriée
    }
  }



//////// End Box Data  ///////////////////////////
//////// Start of Events Data ///////////////////


Future<dynamic> getEventsData(String url, String userId) async {
    try {
      var response = await http.post(
        Uri.parse(url), 
        body: {
          'user_id': userId ??'',
        },
        );
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        //User user = User.fromJson(responsebody['user']);
        print("this is Response Status Code: $responsebody");
        // List<dynamic> jsonResponse = jsonDecode(response.body);
        return responsebody; // Retourne les données décodées si la requête est réussie
      } else {
        print("Error ${response.statusCode}");
        return null; // Ou une autre logique de gestion des erreurs selon votre besoin
      }
    } catch (e) {
      print("Error Catch $e");
      return null; // Gérer les erreurs d'une manière appropriée
    }
  }


//////// End of Events Data ////////////////


//////// Start of Payments Paypal //////////
Future<void> initiatePayment(String plan, Double price, String userId, String ptype, String datePayment,String dateExpired) async {
    // Replace with your backend endpoint
    const url = linkPaypalPayment;

    final response = await http.post(
      Uri.parse(url),
      body: {
        'payment_plan': plan,
        'price': price,
        'payment_type': ptype,
        'date_payment': datePayment,
        'date_expired': dateExpired,
        'user_id': userId},
    );

    if (response.statusCode == 200) {
     var responsebody = jsonDecode(response.body);
     return responsebody;
    } else {
      print("Error ${response.statusCode}");
      return null;
    }
  }




//////// End of Payments Paypal ////////////
///

//////// Start of Plan Price //////////
Future<dynamic> planPrice() async {
    // Replace with your backend endpoint
    const url = linkPlanPrice;

    final response = await http.get(
      Uri.parse(url));
      

    if (response.statusCode == 200) {
     var responsebody = jsonDecode(response.body);
     return responsebody;
    } else {
      print("Error ${response.statusCode}");
      return null;
    }
  }

//////// End of Plan Price ////////////
///


//////// Start of gateway update with position //////////
// Future<dynamic> updateGatewayWithPosition(String userId, String moduleGtwId, Double long, Double lat, String sim ) async {
//     // Replace with your backend endpoint
//     const url = linkUpdateGateway;

//     final response = await http.post(
//       Uri.parse(url),
//       body: {
//         'user_id': userId,
//         'module_gtw_id': moduleGtwId,
//         'longitude': long,
//         'latitude': lat,
//         'num_Sim': sim,
//         },
//     );

//     if (response.statusCode == 200) {
//      var responsebody = jsonDecode(response.body);
//      return responsebody;
//     } else {
//       print("Error ${response.statusCode}");
//       return null;
//     }
//   }




//////// End of Payments Paypal ////////////
///
//////// Start of gateway update without position //////////
Future<dynamic> updateGateway(String userId, String moduleGtwId, String sim, String gwtId ) async {
    // Replace with your backend endpoint
    const url = linkUpdateGateway;

    final response = await http.post(
      Uri.parse(url),
      body: {
        'user_id': userId,
        'module_gtw_id': moduleGtwId,
        'num_Sim': sim,
        'gwt_id' : gwtId,
        },
    );

    if (response.statusCode == 200) {
     var responsebody = jsonDecode(response.body);
     return responsebody;
    } else {
      print("Error ${response.statusCode}");
      return null;
    }
  }




//////// End of Payments Paypal ////////////


//////// Start of add module //////////
Future<dynamic> addModule(String userId, String moduleGtwId, String moduleId, String date, String henhouseId ) async {
    // Replace with your backend endpoint
    const url = linkUpdateGateway;

    final response = await http.post(
      Uri.parse(url),
      body: {
        'user_id': userId,
        'module_gtw_id': moduleGtwId,
        'module_id': moduleId,
        'date' : date,
        'henhouse_id' : henhouseId,

        },
    );

    if (response.statusCode == 200) {
     var responsebody = jsonDecode(response.body);
     return responsebody;
    } else {
      print("Error ${response.statusCode}");
      return null;
    }
  }




//////// End of add module ////////////
///
}