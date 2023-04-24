// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, prefer_interpolation_to_compose_strings, duplicate_ignore, avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracker/login.dart';
import 'package:tracker/mymap.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final auth = FirebaseAuth.instance;
  Stream<Position> position = Geolocator.getPositionStream();
  final Geolocator geolocator = Geolocator();
  StreamSubscription<Position>? _locationSubscription;

  bool change = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Color.fromARGB(255, 7, 3, 3),
            Color.fromRGBO(35, 17, 107, 0.753)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'NBKRIST',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                          child: AlertDialog(
                        title: const Text('Are you sure'),
                        content:
                            const Text('Gps automatically off when you logout'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                auth.signOut().then((value) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                });
                              },
                              child: const Text('logout')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('cancel'))
                        ],
                      ));
                    });
                // auth.signOut().then((value) {
                //   Navigator.pushReplacement(context,
                //       MaterialPageRoute(builder: (context) => LoginScreen()));
                // });
              },
              icon: const Icon(Icons.logout_outlined),
              color: Colors.black,
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Flexible(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("drivers")
                          .where("uid",
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> Driver =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;

                                    // return ListTile(
                                    //  leading: CircleAvatar(
                                    //    child: Text(
                                    //      Driver["bus"],
                                    //      style: TextStyle(
                                    //          fontSize: 20,
                                    //          fontWeight: FontWeight.bold,
                                    //          color: Colors.white),
                                    //    ),
                                    //    radius: 22,
                                    //    backgroundColor: Color(0xFF344D67),
                                    //  ),
                                    //  title: Text(
                                    //    Driver["name"],
                                    //    style: TextStyle(
                                    //      fontSize: 20,
                                    //      fontWeight: FontWeight.bold,
                                    //    ),
                                    //  ),
                                    //  subtitle: Text(Driver["email"]),
                                    //  tileColor: Colors.white,
                                    //  trailing: Icon(Icons.arrow_forward_ios),
                                    //   );

                                    return Container(
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 100),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 50),
                                            child: Container(
                                              height: 100,
                                              width: double.infinity,
                                              decoration: const BoxDecoration(),
                                              child: const Image(
                                                  image: AssetImage(
                                                      'images/bus.png')),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'Thanks for your service',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 24),
                                          child: Container(
                                            height: 300,
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 27, 31, 92),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20))),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 24,
                                                            vertical: 12),
                                                    child: Text(
                                                      'Details',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 24,
                                                        vertical: 24),
                                                    width: double.infinity,
                                                    height: 50,
                                                    decoration: const BoxDecoration(
                                                        color:
                                                            Color(0xFFcffde1),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20))),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          // ignore: prefer_interpolation_to_compose_strings
                                                          "Name :   " +
                                                              Driver['Name']
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Reg No :   " +
                                                              Driver['regno']
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Contact :   " +
                                                              Driver['phone']
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "bus no :    " +
                                                              Driver['busno']
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Container()
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )

                                        // Text(Driver["email"].toString()),
                                        // Text(Driver["name"].toString())
                                      ]),
                                    );
                                  }),
                            );
                          } else {
                            return const Center(child: Text("no data"));
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Flexible(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          'Turn On Your Live Location',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InkWell(
                            onTap: () {
                              change ? _stopListening() : _listenLocation();

                              setState(() {
                                change = !change;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: change
                                      ? Colors.greenAccent
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: change ? Colors.black : Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    change ? 'Tap to OFF' : 'Tap to ON',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: change
                                            ? Colors.black
                                            : Colors.white),
                                  )
                                ],
                              ),
                            )),
                      ),

                      //showing location
                      Expanded(
                          child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('drivers')
                            .where("uid",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> driver =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          driver["latitude"].toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          driver["longitude"].toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.directions,
                                        size: 40,
                                        color: Color.fromARGB(255, 20, 15, 15),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyMap()));
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                      )),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _listenLocation() async {
    _locationSubscription =
        Geolocator.getPositionStream().handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((Position? currentPosition) async {
      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'latitude': currentPosition!.latitude,
          'longitude': currentPosition.longitude,
        },
        // SetOptions(merge: true)
      );
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }
}
