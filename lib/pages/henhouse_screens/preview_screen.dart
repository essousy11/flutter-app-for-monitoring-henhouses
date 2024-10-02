import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {


  String selectedOption = 'Weight';
  List<Map<String, dynamic>> chartData = [
    {'weight': 65, 'temperature': 25, 'humidity': 70},
    {'weight': 66, 'temperature': 26, 'humidity': 71},
    {'weight': 67, 'temperature': 27, 'humidity': 72},
    {'weight': 68, 'temperature': 28, 'humidity': 73},
    // Add more sample data as needed
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedOption;
    //List<Map<String, dynamic>> chartData=[];
  }
  @override
  Widget build(BuildContext context) {
    return 
                  Column(
                                children: [
                                  const Text('fffffffff'),
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
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 1.0,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0,
                                      ),
                                      itemCount: chartData.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          chartData[index][selectedOption.toLowerCase()].toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                          //     ),
                          //  ),
                        
                    );
  }
}