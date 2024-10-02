import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class CardInfoModule extends StatelessWidget {
  final String henhouseId;
  final int humidity;
  final double temperature;
  final double pressure;
  final double weight;
  final String health;
  
  final Function()? onTap;

  const CardInfoModule({
    super.key,
    
    required this.onTap, required this.henhouseId, required this.humidity, required this.temperature, required this.pressure, required this.weight, required this.health, 
    });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        margin: const EdgeInsets.only(top: 16.0),
        width: double.infinity, // Take full width of the screen
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white, // Optional: Add background color
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent, // Make material transparent
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          henhouseId,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    //const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.line_weight, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          '$weight kg',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    //const SizedBox(height: 8),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                      children: [
                        const Icon(Icons.thermostat, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          '$temperature',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.home, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          '$humidity',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                              Row(
                            children: [
                              const Icon(Icons.local_hospital, color: Colors.green),
                              const SizedBox(width: 8),
                              Text(
                                health,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.compress, color: Colors.green),
                                  const SizedBox(width: 8),
                                  Text(
                                    '$pressure',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    
    );
    
  }
}
