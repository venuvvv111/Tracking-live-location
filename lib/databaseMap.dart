// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:location/location.dart' as loc;

class DatabaseMap extends StatefulWidget {
  final String lat;
  final String lan;
  const DatabaseMap({super.key, required this.lat, required this.lan});
  @override
  _DatabaseMapState createState() => _DatabaseMapState();
}

class _DatabaseMapState extends State<DatabaseMap> {
  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  BitmapDescriptor markericon = BitmapDescriptor.defaultMarker;
  // final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  final ref = FirebaseDatabase.instance.ref('users');
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double lat = double.parse(widget.lat);
    double lan = double.parse(widget.lan);
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: size.height,
          child: GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            markers: {
              Marker(
                  position: LatLng(lat, lan),
                  markerId: const MarkerId('id'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueMagenta)),
            },
            initialCameraPosition:
                CameraPosition(target: LatLng(lat, lan), zoom: 10.47),
            onMapCreated: (GoogleMapController controller) async {
              setState(() {
                _controller = controller;
                _added = true;
              });
            },
          ),
        )
      ],
    ));
  }

  // Future<void> mymap(DataSnapshot snapshot) async {
  //   await _controller.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(target: LatLng(34.5678, 45.5678), zoom: 10.00)));
  // }
  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      if (kDebugMode) {
        print('done');
      }
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
