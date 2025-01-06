import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DriverDetailsState();
  }
}
class DriverDetailsState extends State<DriverDetails>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "Driver Details".tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Color.fromARGB(255, 20, 54, 64),
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        elevation: 4,
        shadowColor: const Color.fromARGB(255, 48, 193, 152),
      ),
      body: Center(child:Text("Driver Details"),),
    );
  }

}