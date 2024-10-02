//import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:inscription/core/class/statusrequest.dart';

class Handlingdataview extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const Handlingdataview({super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return 

    statusRequest == StatusRequest.loading ?
    const Center(child: Text("Loading")) : 
    statusRequest == StatusRequest.offlinefailure ?
    const Center(child: Text("offline failure")) : 
    statusRequest == StatusRequest.serverfailure ?
    const Center(child: Text("server failure")) : 
    statusRequest == StatusRequest.failure ?
    const Center(child: Text("No Data", style: TextStyle(fontSize: 20.0))) : widget;
  }
}