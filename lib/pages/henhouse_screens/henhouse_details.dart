
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart'; 
import '../../components/card_info/card_info_module.dart';
import '../../components/crud.dart';
import '../../components/showmessage.dart';
import '../../constant/linkapi.dart';
import '../../main.dart';
import 'chart_screen.dart';
import 'package:intl/intl.dart'; // For date formatting
//import 'preview_screen.dart';

class HenhouseDetails extends StatefulWidget {
  final String place;

  const HenhouseDetails({Key? key, required this.place}) : super(key: key);

  @override
  _HenhouseDetailsState createState() => _HenhouseDetailsState();
}

class _HenhouseDetailsState extends State<HenhouseDetails> {
  bool isPreview = false;
  Crud crud = Crud();
  List<Map<String, dynamic>> cardData = [];
    List<Map<String, dynamic>> boxData = [];


  @override
  void initState() {
    super.initState();
    userDataCard();
    getBoxData();
    _dateController = TextEditingController(text: _getCurrentDate());
  }

  String _getCurrentDate() {
    // Get current date in the format yyyy-MM-dd (change format as needed)
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }


  userDataCard() async {
  try {
    String? userId = sharedPref.getString("user_id");
    print("User ID: $userId");

    if (userId != null) {
      var userDataCardResponse = await crud.userModuleCard(linkModuleCard, userId, widget.place);

        setState(() {
          if (userDataCardResponse['status'] == "success") {
            cardData = List<Map<String, dynamic>>.from(userDataCardResponse['data']);
            print("cardData: $cardData");
            // var index = cardData.length - 1;
            

          } else {
            cardData = [];
          }
        });
      //} else {
        // Handle case where 'data' key is null or does not exist
        //print("No valid data found in userDataCardResponse");
      //}
    } else {
      print("User ID is null");
    }
  } catch (e) {
    print("Error: $e");
  }
}

  ////////// Start of Box Data function ////////////
  getBoxData() async {
    try {
      String? userId = sharedPref.getString("user_id");
      
      String? moduleGtwId = sharedPref.getString("module_gtw_id");
      print("User ID: $userId and module_gtw_id == $moduleGtwId");

      if (userId != null) {
        var boxDataResponse = await crud.getBoxData(linkBoxData, userId, moduleGtwId!);

        setState(() {
          if (boxDataResponse['status'] == "success") {
            boxData = List<Map<String, dynamic>>.from(boxDataResponse['data']);
            print("this is the box data : $boxData");
            

          } else {
            boxData = [];
          }
        });
      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error: $e");
    }
  }


  ////////// End of Box Data Function  //////////////
  String selectedOption = 'Weight';

  //// start of add henhouse function//////
  
  addHenhouse( String moduleGtwId, String moduleId, String date, String henhouseId) async {
    String? userId = sharedPref.getString("user_id");
   if (userId != null) {
        var updateGatewayData = await crud.addModule(userId, moduleGtwId, moduleId, date, henhouseId);
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
        else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
              return const Showmessage(title: 'Update Gateway', message: 'Votre gateway infos sont pas correct');
              }
        );
        }
  }
  else {
    showDialog(
              context: context,
              builder: (BuildContext context) {
              return const Showmessage(title: 'Update Gateway', message: 'Votre gateway infos sont pas correct');
              }
  );
  }
  }


  ////// End of add henhouse function ///////
  
  ////// Add henhouse Details ////////////
  ///
  TextEditingController _henhouseIdController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _moduleIdController = TextEditingController();
  Future<void> _showAddHenhouseDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Henhouse'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _henhouseIdController,
                  decoration: InputDecoration(hintText: "Enter Gateway ID"),
                ),
                TextField(
                  controller: _dateController,
                  enabled: false,
                  decoration: InputDecoration(hintText: "Current Date"),
                ),
                TextField(
                  controller: _moduleIdController,
                  decoration: InputDecoration(hintText: "Enter Module Gateway ID"),
                  enabled: false,
                ),
                IconButton(
                  icon: Icon(Icons.qr_code_scanner),
                  onPressed: () async {
                    var result = await BarcodeScanner.scan();
                    if (result.rawContent.isNotEmpty) {
                      setState(() {
                        _moduleIdController.text = result.rawContent;
                      });
                      Navigator.of(context).pop(); // Close the scanner dialog
                      _showAddHenhouseDialog(); // Reopen the add gateway dialog with updated moduleGtwId
                    }
                  },
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
              child: Text('Add'),
              onPressed: () {
                // Handle adding the gateway and module_gtw_id
                //Navigator.of(context).pop();
                          AlertDialog(

            title: Text('henhous added'),

            content: Text('henhouse added successfully'),

            actions: <Widget>[

              TextButton(

                child: const Text('OK'),

                onPressed: () {

                  Navigator.of(context).pop();

                },

              ),

              // TextButton(

              //   child: const Text('Confirm'),

              //   onPressed: () {

              //     // Handle the confirm action
              //     confirmButton;

              //   },

              // ),

            ],

          );
              },
            ),
          ],
        );
      },
    );
  }

  //////// End of add henhouse Détails ///////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                color: Colors.orange.shade200,
                borderRadius: BorderRadius.circular(12.0),
              ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //InfoRow(icon: Icons.thermostat, label: '34'),
                    InfoRow(
                        icon: Icons.thermostat,
                        label: cardData.isNotEmpty ? cardData[0]['ext_temperature'].toString() : '',
                      ),
                      InfoRow(
                        icon: Icons.compress,
                        label: cardData.isNotEmpty ? cardData[0]['ext_pressure'].toString() : '',
                      ),
                      InfoRow(
                        icon: Icons.scale,
                        label: cardData.isNotEmpty ? cardData[0]['total_weight'].toString() : '',
                      ),
                      InfoRow(
                        icon: Icons.opacity,
                        label: cardData.isNotEmpty ? cardData[0]['ext_humidity'].toString() : '',
                      ),

                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Details', style: Theme.of(context).textTheme.bodyMedium),
                  Switch(
                    value: isPreview,
                    onChanged: (value) {
                      setState(() {
                        isPreview = value;
                      });
                    },
                  ),
                  Text('Preview', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 20),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: isPreview
                    ?
                    ///////// Start of Preview Part ////////
                    // Column(
                    //       children: [
                    //         DropdownButton<String>(
                    //           value: selectedOption,
                    //           items: <String>['Weight', 'Temperature', 'Humidity'].map((String value) {
                    //             return DropdownMenuItem<String>(
                    //               value: value,
                    //               child: Text(value),
                    //             );
                    //           }).toList(),
                    //           onChanged: (newValue) {
                    //             setState(() {
                    //               selectedOption = newValue!;
                                
                    //             });
                    //           },
                    //         ),
                    //         const SizedBox(height: 20),
                    //         SizedBox(
                    //           height: 200, // Adjust the height to fit your content
                    //           child: GridView.builder(
                    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //               crossAxisCount: 4,
                    //               childAspectRatio: 1.0,
                    //               crossAxisSpacing: 4.0,
                    //               mainAxisSpacing: 4.0,
                    //             ),
                    //             itemCount: boxData.length,
                    //             itemBuilder: (context, index) {
                    //               return 
                    //                Container(
                    //                   decoration: BoxDecoration(
                    //                     border: Border.all(color: Colors.black),
                    //                   ),
                    //                   child: Center(
                    //                     child: Text(
                    //                       boxData[index][selectedOption.toLowerCase()].toString(),
                    //                       style: const TextStyle(fontSize: 16),
                    //                     ),
                    //                   ),
                    //                 );
                                
                    //             },
                    //           ),
                    //         ),
                    //       ],
                    //     )
                    Column(
                        children: [
                          DropdownButton<String>(
                            value: selectedOption,
                            items: <String>['Weight', 'Temperature', 'Humidity']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedOption = newValue!;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 200,
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.0,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                              ),
                              itemCount: boxData.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Center(
                                    child: Text(
                                      boxData[index][selectedOption.toLowerCase()].toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ///////// End of Preview Part ////////
                    :
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cardData.length,
                      itemBuilder: (context, index) {
                        var item = cardData[index];
                        return CardInfoModule(
                          henhouseId: item['henhouse_id'].toString(),
                          weight: double.parse(item['weight']), // Assuming total_weight is numeric
                          temperature: double.parse(item['temperature']),
                          humidity: int.parse(item['humidity']),
                          pressure: double.parse(item['pressure']),
                          health: item['health'].toString(),
                          onTap: () {
                            // Handle tap if needed
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChartScreen(
                                  weight: double.parse(item['total_weight']),
                                  temperature: double.parse(item['ext_temperature']),
                                  humidity: int.parse(item['ext_humidity']),
                                  henhouseId: item['henhouse_id'].toString(),
                                  place: widget.place,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: _showAddHenhouseDialog,
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  

  const InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          padding: EdgeInsets.all(12.0),
          child: Icon(icon, color: Colors.orange),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

