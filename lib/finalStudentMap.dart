// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;

class FinalMap extends StatefulWidget {
  final double latitude, longitude;

  final String bus;

  const FinalMap(
      {super.key,
      required this.bus,
      required this.latitude,
      required this.longitude});
  @override
  _FinalMapState createState() => _FinalMapState();
}

class _FinalMapState extends State<FinalMap> {
  // final loc.Location location = loc.Location();

  late GoogleMapController _controller;
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("drivers")
          .where("busno", isEqualTo: widget.bus)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (_added) {
          mymap(snapshot);
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> Driver =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              return Stack(
                children: [
                  SizedBox(
                    height: size.height,
                    child: GoogleMap(
                      scrollGesturesEnabled: true,
                      mapType: MapType.normal,
                      markers: {
                        Marker(
                            position:
                                LatLng(Driver['latitude'], Driver['longitude']),
                            markerId: const MarkerId('id'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueMagenta)),
                      },
                      initialCameraPosition: CameraPosition(
                          target:
                              LatLng(Driver['latitude'], Driver['longitude']),
                          zoom: 12.47),
                      onMapCreated: (GoogleMapController controller) async {
                        setState(() {
                          _controller = controller;
                          _added = true;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {},
                    ),
                  )
                ],
              );
            });
      },
    ));
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        widget.latitude,
        widget.longitude,
      ),
      zoom: 10.90,
    )));
  }
}
