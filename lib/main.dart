import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:tracker/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginScreen(),
      home: Splash()));
}













// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // Stream<Position> position = Geolocator.getPositionStream();
//   // final Geolocator geolocator = Geolocator();
//   // StreamSubscription<Position>? _locationSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _requestPermission();
//     final LocationSettings locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 100,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('live location tracker'),
//       ),
//       body: Column(
//         children: [
//           Container(),
//           TextButton(
//               onPressed: () {
//                 _listenLocation();
//               },
//               child: Text('enable live location')),
//           TextButton(
//               onPressed: () {
//                 _stopListening();
//               },
//               child: Text('stop live location')),
//           Expanded(
//               child: StreamBuilder(
//             stream:
//                 FirebaseFirestore.instance.collection('location').snapshots(),
//             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return ListView.builder(
//                   itemCount: snapshot.data?.docs.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title:
//                           Text(snapshot.data!.docs[index]['name'].toString()),
//                       subtitle: Row(
//                         children: [
//                           Text(snapshot.data!.docs[index]['latitude']
//                               .toString()),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Text(snapshot.data!.docs[index]['longitude']
//                               .toString()),
//                         ],
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.directions),
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) =>
//                                   MyMap(snapshot.data!.docs[index].id)));
//                         },
//                       ),
//                     );
//                   });
//             },
//           )),
//         ],
//       ),
//     );
//   }

//   // _getLocation() async {
//   //   try {
//   //     // final Position locationResult = await Position.getLocation();
//   //     await FirebaseFirestore.instance.collection('location').doc('user1').set({
//   //       'latitude': locationResult.latitude,
//   //       'longitude': locationResult.longitude,
//   //       'name': 'john'
//   //     }, SetOptions(merge: true));
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }

//   Future<void> _listenLocation() async {
//     _locationSubscription =
//         Geolocator.getPositionStream().handleError((onError) {
//       print(onError);
//       _locationSubscription?.cancel();
//       setState(() {
//         _locationSubscription = null;
//       });
//     }).listen((Position? currentPosition) async {
//       await FirebaseFirestore.instance.collection('location').doc('user5').set({
//         'latitude': currentPosition!.latitude,
//         'longitude': currentPosition.longitude,
//         'name': 'john'
//       }, SetOptions(merge: true));
//     });
//   }

//   _stopListening() {
//     _locationSubscription?.cancel();
//     setState(() {
//       _locationSubscription = null;
//     });
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
