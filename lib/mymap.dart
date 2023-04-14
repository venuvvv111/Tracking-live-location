// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;

class MyMap extends StatefulWidget {
  const MyMap({super.key});
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  BitmapDescriptor markericon = BitmapDescriptor.defaultMarker;
  // final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('drivers').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (_added) {
          mymap(snapshot);
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return GoogleMap(
          mapType: MapType.normal,
          markers: {
            Marker(
                position: LatLng(
                  snapshot.data!.docs.singleWhere((element) =>
                      element.id ==
                      FirebaseAuth.instance.currentUser!.uid)['latitude'],
                  snapshot.data!.docs.singleWhere((element) =>
                      element.id ==
                      FirebaseAuth.instance.currentUser!.uid)['longitude'],
                ),
                markerId: const MarkerId('id'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueMagenta)),
          },
          initialCameraPosition: CameraPosition(
              target: LatLng(
                snapshot.data!.docs.singleWhere((element) =>
                    element.id ==
                    FirebaseAuth.instance.currentUser!.uid)['latitude'],
                snapshot.data!.docs.singleWhere((element) =>
                    element.id ==
                    FirebaseAuth.instance.currentUser!.uid)['longitude'],
              ),
              zoom: 15.47),
          onMapCreated: (GoogleMapController controller) async {
            setState(() {
              _controller = controller;
              _added = true;
            });
          },
        );
      },
    ));
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere((element) =>
                  element.id ==
                  FirebaseAuth.instance.currentUser!.uid)['latitude'],
              snapshot.data!.docs.singleWhere((element) =>
                  element.id ==
                  FirebaseAuth.instance.currentUser!.uid)['longitude'],
            ),
            zoom: 15.00)));
  }
}
