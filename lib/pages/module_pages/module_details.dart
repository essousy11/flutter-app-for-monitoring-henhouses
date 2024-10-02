import 'package:flutter/material.dart';


class ModuleDetails extends StatelessWidget {
  const ModuleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle('SIM Information'),
            _buildInfoRow('Sim operator', 'Vodafone'),
            _buildInfoRow('ICCID', '8920202002568'),
            _buildInfoRow('IMEI', '8648945123644'),
            _buildInfoRow('SIM IMSI', '204080501812'),
            Divider(),
            _buildSectionTitle('Network provider'),
            _buildInfoRow('Operator', 'Vodafone NL'),
            _buildInfoRow('MCC', '204'),
            _buildInfoRow('MNC', '04'),
            Divider(),
            _buildSectionTitle('Serving Cell'),
            _buildInfoRow('Data Net', 'LTE'),
            _buildInfoRow('Data Type', 'LTE'),
            _buildInfoRow('TAC', '62603'),
            _buildInfoRow('PCI', '118'),
            _buildInfoRow('ECI', '139548449(54511-33)'),
            _buildInfoRow('EARFCN', '1300/19300'),
            _buildInfoRow('FREQ', '1815/1720'),
            _buildInfoRow('BAND', '3 FDD'),
            Divider(),
            _buildSectionTitle('Signal Strength'),
            _buildSignalStrengthRow('RSRP', '-104'),
            _buildSignalStrengthRow('RSRQ', '-15'),
            _buildSignalStrengthRow('SINR', '2.2'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label, style: TextStyle(fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSignalStrengthRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Text(label, style: TextStyle(fontSize: 16)),
          SizedBox(width: 10),
          Container(
            width: 50,
            height: 10,
            color: Colors.green,
            child: Center(
              child: Text(value, style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
