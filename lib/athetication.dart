// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Location extends StatefulWidget {
//   const Location({super.key});

//   @override
//   State<Location> createState() => _LocationState();
// }

// class _LocationState extends State<Location> {
//   final Gps _gps = Gps();
//   Position? userPosition;
//   Exception? _exception;
//   void _handle(Position position) {
//     setState(() {
//       userPosition = position;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _requestPermission();
//     _gps.startPositionStream(_handle);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//             child: FloatingActionButton(onPressed: () {
//               _gps.startPositionStream((position) => userPosition.toString());
//             }),
//           ),
//           Text(userPosition.toString())
//         ],
//       ),
//     );
//   }

//   _requestPermission() async {
//     var status = await Permission.location.request();
//     if (status.isGranted) {
//       print('done');
//     } else if (status.isDenied) {
//       _requestPermission();
//     } else if (status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//   }
// }

// class Gps {
//   bool isAccessGranted(LocationPermission permission) {
//     return permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always;
//   }

//   Future<bool> requestPermision() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (isAccessGranted(permission)) {
//       return true;
//     }
//     permission = await Geolocator.requestPermission();
//     return isAccessGranted(permission);
//   }

//   Future<void> startPositionStream(Function(Position position) callback) async {
//     bool permissionGranted = await requestPermision();
//     if (!permissionGranted) {
//       throw Exception("user did not gramt permision");
//     }
//     Geolocator.getPositionStream(
//             locationSettings:
//                 LocationSettings(accuracy: LocationAccuracy.bestForNavigation))
//         .listen((Position position) async {
//       await FirebaseFirestore.instance.collection('location').doc('user3').set({
//         'latitude': position.latitude,
//         'longitude': position.longitude,
//         'name': 'john'
//       }, SetOptions(merge: true));
//     });
//   }
// }
