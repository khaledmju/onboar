import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main.dart';

class Driver extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DriverState();
  }
}
class DriverState extends State<Driver>{
//   String? driverLogo;
//   @override
//   void initState() {
//     driverLogo = prefs!.getString("driverLogo ");
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            prefs!.setBool('showHome', false);
            prefs!.clear();
            Get.offAll(()=> OnboardingPage(),);
          }, icon: Icon(Icons.logout))
        ],
        title: Text(
          "Driver".tr,
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
      body: Center(child:Text("Driver"),),);}}
//       body: Center(
//         child: driverLogo != null
//             ? Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ClipOval(
//               child: Image.network(
//                 driverLogo!,
//                 height: 150,
//                 width: 150,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Icon(
//                     Icons.account_circle,
//                     size: 150,
//                     color: Colors.grey,
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Welcome, Driver!",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//           ],
//         )
//             : const CircularProgressIndicator(), // Show a loader while retrieving the logo
//       ),
//     );
//   }
// }