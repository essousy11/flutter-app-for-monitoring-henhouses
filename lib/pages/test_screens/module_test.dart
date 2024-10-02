import 'package:flutter/material.dart';



class ModuleTest extends StatefulWidget {
  @override
  _ModuleTestState createState() => _ModuleTestState();
}

class _ModuleTestState extends State<ModuleTest> {
  bool _isPreview = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black54),
            ),
            child: Column(
              children: <Widget>[
                Text('EXT_hum', style: TextStyle(fontSize: 18)),
                Text('EXT_TEMP', style: TextStyle(fontSize: 18)),
                Text('EXT_pressure', style: TextStyle(fontSize: 18)),
                Text('Total_weight', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Preview'),
              Switch(
                value: !_isPreview,
                onChanged: (value) {
                  setState(() {
                    _isPreview = !value;
                  });
                },
              ),
              Text('Details'),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black54),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'henhouse_id',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('Humidity', style: TextStyle(fontSize: 16)),
                    Text('Temp', style: TextStyle(fontSize: 16)),
                    Text('Pressure', style: TextStyle(fontSize: 16)),
                    Text('Health', style: TextStyle(fontSize: 16)),
                    Text('Weight', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text('Second henhouse Information'),
          ),
          Spacer(),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
