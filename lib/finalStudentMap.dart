// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracker/screens/area.dart';
import 'package:url_launcher/url_launcher.dart';
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
  late BitmapDescriptor customMarker;
  // final loc.Location location = loc.Location();
  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'images/bus.png',
    ).then((value) => setState(() {
          customMarker = value;
        }));
  }

  Future<void> _launchNBKR() async {
    const url = 'https://com.nbkr.nbkrist.co.in/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _textMe() async {
    const url = 'sms:+91 7702645478?body=hello%20 Nbkristian';
    // Android
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: size.height / 4,
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 16,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Student',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Area()));
                },
                child: const ListTile(
                  leading: Icon(Icons.home),
                  title: Text(
                    'Home',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_rounded,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.pushReplacement(
                  //     context, MaterialPageRoute(builder: (context) => Area()));
                  _launchNBKR();
                },
                child: const ListTile(
                  leading: Icon(Icons.details_outlined),
                  title: Text(
                    'About  NBKRIST',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_rounded,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.pushReplacement(
                  //     context, MaterialPageRoute(builder: (context) => Area()));
                  _textMe();
                },
                child: const ListTile(
                  leading: Icon(Icons.message),
                  title: Text(
                    'Contact',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_rounded,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const ListTile(
                  leading: Icon(Icons.backspace_outlined),
                  title: Text(
                    'Back',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_rounded,
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('NBKR DYNAMO'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("drivers")
              .where("busno", isEqualTo: widget.bus)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // if (_added) {
            //   mymap(snapshot);
            // }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Now Selected Bus ${widget.bus} Is In Live',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      const Text(
                        'NBKRIST',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      )
                    ],
                  ),
                )),
                SizedBox(
                  height: size.height / 2,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> Driver = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;

                        return GoogleMap(
                          scrollGesturesEnabled: true,
                          mapType: MapType.normal,
                          markers: {
                            Marker(
                                position: LatLng(
                                    Driver['latitude'], Driver['longitude']),
                                markerId: const MarkerId('id'),
                                icon: customMarker),
                          },
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          padding: EdgeInsets.only(top: size.height / 4),
                          zoomControlsEnabled: false,
                          compassEnabled: true,
                          initialCameraPosition: CameraPosition(
                            zoom: 16,
                            target:
                                LatLng(Driver['latitude'], Driver['longitude']),
                          ),
                          onMapCreated: (GoogleMapController controller) async {
                            setState(() {});
                          },
                        );
                      }),
                ),
              ],
            );
          },
        ));
  }

  // Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
  //   await _controller
  //       .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //           target: LatLng(
  //             widget.latitude,
  //             widget.longitude,
  //           ),
  //           zoom: 16)));
  // }
}
