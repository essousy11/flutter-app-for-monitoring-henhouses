import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class CardInfoGateway extends StatelessWidget {
  final String city;
  final double weight;
  final int henhouseNumber;
  final String gwtId;
  final DateTime nowDate = DateTime.now();
  
  final Function()? onTap;

  CardInfoGateway({
    super.key,
    required this.city,
    required this.weight,
    required this.henhouseNumber,
    required this.onTap, 
    required this.gwtId,
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
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          city,
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
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.home, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          '$henhouseNumber Henhouse',
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
                          'Gateway ID: $gwtId',
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
                        const Icon(Icons.date_range, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          '$nowDate',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
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
