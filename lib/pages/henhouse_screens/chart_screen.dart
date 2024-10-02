// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';

// import '../../components/crud.dart';
// import '../../constant/linkapi.dart';
// import '../../main.dart';
// import 'henhouse_details.dart';

// class ChartScreen extends StatefulWidget {
//   final double weight;
//   final double temperature;
//   final int humidity;
//   final String henhouseId;
//   final String place;

//   ChartScreen({
//     Key? key,
//     required this.weight,
//     required this.temperature,
//     required this.humidity,
//     required this.henhouseId,
//     required this.place,
//   }) : super(key: key);

//   @override
//   _ChartScreenState createState() => _ChartScreenState();
// }

// class _ChartScreenState extends State<ChartScreen> {
//   String selectedOption = 'Weight';
//   DateTime? startDate;
//   DateTime? endDate;
//   Crud crud = Crud();
//   List<Map<String, dynamic>> chartData = [];
//   List <Map<String, dynamic>> eventsData=[];

//   @override
//   void initState() {
//     super.initState();
//     // Set initial dates to last week
//     startDate = DateTime.now();
//     endDate = startDate!.add((Duration(days: 7)));
//     //startDate = endDate!.subtract(Duration(days: 7));
//     _getChartData(); // Fetch initial chart data
//     getEventsData();
//   }

//   _getChartData() async {
//   String? userId = sharedPref.getString("user_id");
//   print("User ID: $userId");

//   if (userId != null && startDate != null && endDate != null) {
//     var userChartDataResponse = await crud.getChartData(
//       linkChartData,
//       userId,
//       startDate!.toString(),
//       endDate!.toString(),
//     );

//     print("User Chart Data Response: $userChartDataResponse");

//     if (userChartDataResponse != null && userChartDataResponse.containsKey('status')) {
//       if (userChartDataResponse['status'] == "success" && userChartDataResponse.containsKey('data')) {
//         setState(() {
//           chartData = List<Map<String, dynamic>>.from(
//             userChartDataResponse['data'].map((item) => {
//               'weight': double.parse(item['weight']),
//               'temperature': double.parse(item['temperature']),
//               'humidity': int.parse(item['humidity']),
//               'date': DateTime.parse(item['date']),
//             }),
//           );
//           print("Chart data: $chartData");
//         });
//       } else {
//         setState(() {
//           chartData = [];
//           print("Chart data is empty or status is not success");
//         });
//       }
//     } else {
//       print("Invalid response structure");
//     }
//   } else {
//     print("User ID or dates are null");
//   }
// }


// ////////// Start of Events Data function ////////////
//   getEventsData() async {
//     try {
//       String? userId = sharedPref.getString("user_id");
      
//       if (userId != null) {
//         var eventsDataResponse = await crud.getEventsData(linkEventsData, userId);

//         setState(() {
//           if (eventsDataResponse['status'] == "success") {
//             eventsData = List<Map<String, dynamic>>.from(eventsDataResponse['data']);
//             print("cardData: $eventsData");
            

//           } else {
//             eventsData = [];
//           }
//         });
//       } else {
//         print("User ID is null");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }


//   ////////// End of Events Data Function  //////////////

//   Future<void> _pickStartDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: startDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != startDate) {
//       setState(() {
//         startDate = picked;
//         if (endDate != null && endDate!.isBefore(startDate!)) {
//           endDate = null;
//         }
//         _getChartData(); // Fetch new data when date changes
//       });
//     }
//   }

//   Future<void> _pickEndDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: endDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != endDate) {
//       if (startDate != null && picked.isBefore(startDate!)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('End date must be after start date')),
//         );
//       } else {
//         setState(() {
//           endDate = picked;
//           _getChartData(); // Fetch new data when date changes
//         });
//       }
//     }
//   }

//   List<FlSpot> _generateSpots() {
//     List<FlSpot> spots = [];
//     if (chartData.isNotEmpty) {
//       for (int i = 0; i < chartData.length; i++) {
//         double value = 0.0;
//         switch (selectedOption) {
//           case 'Weight':
//             value = chartData[i]['weight'];
//             break;
//           case 'Temperature':
//             value = chartData[i]['temperature'];
//             break;
//           case 'Humidity':
//             value = chartData[i]['humidity'].toDouble();
//             break;
//         }
//         spots.add(FlSpot(i.toDouble(), value));
//       }
//     }
//     return spots;
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => HenhouseDetails(place: widget.place),
//               ),
//             );
//           },
//         ),
//         title: Text(widget.henhouseId),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.orange.shade200,
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   InfoCard(
//                     icon: Icons.fitness_center,
//                     label: 'Weight',
//                     value: '${widget.weight.toString()} kg',
//                   ),
//                   InfoCard(
//                     icon: Icons.thermostat,
//                     label: 'Temperature',
//                     value: '${widget.temperature.toString()} °C',
//                   ),
//                   InfoCard(
//                     icon: Icons.opacity,
//                     label: 'Humidity',
//                     value: '${widget.humidity.toString()} %',
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 40),
//             Container(
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.orange.shade200,
//                           borderRadius: BorderRadius.circular(4.0),
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             value: selectedOption,
//                             items: <String>['Weight', 'Temperature', 'Humidity']
//                                 .map((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(value),
//                               );
//                             }).toList(),
//                             onChanged: (newValue) {
//                               setState(() {
//                                 selectedOption = newValue!;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       Column(
//                         children: [
//                           GestureDetector(
//                             onTap: () => _pickStartDate(context),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade200,
//                                 borderRadius: BorderRadius.circular(4.0),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.calendar_today, size: 16.0),
//                                   SizedBox(width: 8.0),
//                                   Text(
//                                     startDate == null
//                                         ? 'Start Date'
//                                         : DateFormat('yyyy-MM-dd').format(startDate!),
//                                     style: TextStyle(fontSize: 16.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () => _pickEndDate(context),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade200,
//                                 borderRadius: BorderRadius.circular(4.0),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.calendar_today, size: 16.0),
//                                   SizedBox(width: 8.0),
//                                   Text(
//                                     endDate == null
//                                         ? 'End Date'
//                                         : DateFormat('yyyy-MM-dd').format(endDate!),
//                                     style: TextStyle(fontSize: 16.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   SizedBox(height: 200),
//                   child: LineChart(
//                       LineChartData(
//                         gridData: FlGridData(show: false),
//                         borderData: FlBorderData(
//                           show: true,
//                           border: Border.all(
//                             color: Colors.grey,
//                             width: 1,
//                           ),
//                         ),
//                         titlesData: FlTitlesData(
//                           leftTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               getTitlesWidget: (value, meta) {
//                                 return Text(value.toInt().toString());
//                               },
//                               //margin: 10,
//                             ),
//                           ),
//                           bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               getTitlesWidget: (value, meta) {
//                                 if (chartData.isNotEmpty && value.toInt() < chartData.length) {
//                                   return Text(DateFormat('dd').format(chartData[value.toInt()]['date']));
//                                 }  
//                                 return const Text('');
//                               },
//                               //margin: 10,
//                             ),
//                           ),
//                           topTitles: AxisTitles(
//                           sideTitles: SideTitles(showTitles: false),
//                           ),
//                           rightTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false),
//                           ),
//                         ),
//                         lineBarsData: [
//                           LineChartBarData(
//                             spots: _generateSpots(),
//                             isCurved: true,
//                             color: Colors.blue,
//                             barWidth: 4,
//                             belowBarData: BarAreaData(
//                               show: true,
//                               color: Colors.blue.withOpacity(0.3),
//                             ),
//                           ),
//                         ],
//                         lineTouchData: LineTouchData(
//                           touchTooltipData: LineTouchTooltipData(
//                             //tooltipBgColor: Colors.blueAccent,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     )
//   }
// }

// class InfoCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;

//   const InfoCard({required this.icon, required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white,
//           ),
//           padding: EdgeInsets.all(12.0),
//           child: Icon(icon, color: Colors.orange),
//         ),
//         SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../components/crud.dart';
import '../../constant/linkapi.dart';
import '../../main.dart';
import 'henhouse_details.dart';

class ChartScreen extends StatefulWidget {
  final double weight;
  final double temperature;
  final int humidity;
  final String henhouseId;
  final String place;

  ChartScreen({
    Key? key,
    required this.weight,
    required this.temperature,
    required this.humidity,
    required this.henhouseId,
    required this.place,
  }) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  String selectedOption = 'Weight';
  DateTime? startDate;
  DateTime? endDate;
  Crud crud = Crud();
  List<Map<String, dynamic>> chartData = [];
  List<Map<String, dynamic>> eventsData = [];

  @override
  void initState() {
    super.initState();
    // Set initial dates to last week
    startDate = DateTime.now();
    endDate = startDate!.add(Duration(days: 7));
    //startDate = endDate!.subtract(Duration(days: 7));
    _getChartData(); // Fetch initial chart data
    getEventsData();
  }

  _getChartData() async {
    String? userId = sharedPref.getString("user_id");
    print("User ID: $userId");

    if (userId != null && startDate != null && endDate != null) {
      var userChartDataResponse = await crud.getChartData(
        linkChartData,
        userId,
        startDate!.toString(),
        endDate!.toString(),
      );

      print("User Chart Data Response: $userChartDataResponse");

      if (userChartDataResponse != null && userChartDataResponse.containsKey('status')) {
        if (userChartDataResponse['status'] == "success" && userChartDataResponse.containsKey('data')) {
          setState(() {
            chartData = List<Map<String, dynamic>>.from(
              userChartDataResponse['data'].map((item) => {
                'weight': double.parse(item['weight']),
                'temperature': double.parse(item['temperature']),
                'humidity': int.parse(item['humidity']),
                'date': DateTime.parse(item['date']),
              }),
            );
            print("Chart data: $chartData");
          });
        } else {
          setState(() {
            chartData = [];
            print("Chart data is empty or status is not success");
          });
        }
      } else {
        print("Invalid response structure");
      }
    } else {
      print("User ID or dates are null");
    }
  }

  ////////// Start of Events Data function ////////////
  getEventsData() async {
    try {
      String? userId = sharedPref.getString("user_id");

      if (userId != null) {
        var eventsDataResponse = await crud.getEventsData(linkEventsData, userId);

        setState(() {
          if (eventsDataResponse['status'] == "success") {
            eventsData = List<Map<String, dynamic>>.from(eventsDataResponse['data']);
            print("cardData: $eventsData");
          } else {
            eventsData = [];
          }
        });
      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  ////////// End of Events Data Function  //////////////

  Future<void> _pickStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        if (endDate != null && endDate!.isBefore(startDate!)) {
          endDate = null;
        }
        _getChartData(); // Fetch new data when date changes
      });
    }
  }

  Future<void> _pickEndDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate) {
      if (startDate != null && picked.isBefore(startDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('End date must be after start date')),
        );
      } else {
        setState(() {
          endDate = picked;
          _getChartData(); // Fetch new data when date changes
        });
      }
    }
  }

  List<FlSpot> _generateSpots() {
    List<FlSpot> spots = [];
    if (chartData.isNotEmpty) {
      for (int i = 0; i < chartData.length; i++) {
        double value = 0.0;
        switch (selectedOption) {
          case 'Weight':
            value = chartData[i]['weight'];
            break;
          case 'Temperature':
            value = chartData[i]['temperature'];
            break;
          case 'Humidity':
            value = chartData[i]['humidity'].toDouble();
            break;
        }
        spots.add(FlSpot(i.toDouble(), value));
      }
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HenhouseDetails(place: widget.place),
              ),
            );
          },
        ),
        title: Text(widget.henhouseId),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InfoCard(
                    icon: Icons.fitness_center,
                    label: 'Weight',
                    value: '${widget.weight.toString()} kg',
                  ),
                  InfoCard(
                    icon: Icons.thermostat,
                    label: 'Temperature',
                    value: '${widget.temperature.toString()} °C',
                  ),
                  InfoCard(
                    icon: Icons.opacity,
                    label: 'Humidity',
                    value: '${widget.humidity.toString()} %',
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
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
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => _pickStartDate(context),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade200,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16.0),
                                  SizedBox(width: 8.0),
                                  Text(
                                    startDate == null
                                        ? 'Start Date'
                                        : DateFormat('yyyy-MM-dd').format(startDate!),
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _pickEndDate(context),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade200,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16.0),
                                  SizedBox(width: 8.0),
                                  Text(
                                    endDate == null
                                        ? 'End Date'
                                        : DateFormat('yyyy-MM-dd').format(endDate!),
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(value.toInt().toString());
                              },
                              //margin: 10,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (chartData.isNotEmpty && value.toInt() < chartData.length) {
                                  return Text(DateFormat('dd').format(chartData[value.toInt()]['date']));
                                }
                                return const Text('');
                              },
                              //margin: 10,
                            ),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: _generateSpots(),
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 4,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue.withOpacity(0.3),
                            ),
                          ),
                        ],
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            //tooltipBgColor: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoCard({required this.icon, required this.label, required this.value});

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
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}


