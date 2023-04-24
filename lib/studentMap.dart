// ignore_for_file: file_names, non_constant_identifier_names, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'finalStudentMap.dart';

class StudentMap extends StatefulWidget {
  final String bus;
  const StudentMap({super.key, required this.bus});

  @override
  State<StudentMap> createState() => _StudentMapState();
}

class _StudentMapState extends State<StudentMap> {
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
          leading: const BackButton(color: Colors.black),
          title: const Text(
            'NBKRIST',
            style: TextStyle(color: Colors.black),
          ),
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
                          .where("busno", isEqualTo: widget.bus)
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
                                              horizontal: 24, vertical: 40),
                                          child: Container(
                                            height: 250,
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
                                                          "Name     :  " +
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
                                                          "Reg No   :  " +
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
                                                          "Contact  :  " +
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
                                                          "Bus No   :  " +
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
                            return const Center(
                                child: Text(
                              "no data",
                              style: TextStyle(color: Colors.white),
                            ));
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
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("drivers")
                          .where("busno", isEqualTo: widget.bus)
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
                              Map<String, dynamic> Driver =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;

                              return Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: Text(
                                        "Hurrah! You're bus is on the way",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        Text(Driver['latitude'].toString()),
                                        Text(Driver['longitude'].toString())
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FinalMap(
                                                          bus: widget.bus,
                                                          latitude: Driver[
                                                              'latitude'],
                                                          longitude: Driver[
                                                              'longitude'],
                                                        )));
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Track Here",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),

                                    //showing location
                                    //   Expanded(
                                    //       child: StreamBuilder(
                                    //     stream: FirebaseFirestore.instance
                                    //         .collection('drivers')
                                    //         .where("uid",
                                    //             isEqualTo:
                                    //                 FirebaseAuth.instance.currentUser!.uid)
                                    //         .snapshots(),
                                    //     builder:
                                    //         (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    //       if (!snapshot.hasData) {
                                    //         return Center(child: CircularProgressIndicator());
                                    //       }
                                    //       return ListView.builder(
                                    //           itemCount: snapshot.data!.docs.length,
                                    //           itemBuilder: (context, index) {
                                    //             Map<String, dynamic> driver =
                                    //                 snapshot.data!.docs[index].data()
                                    //                     as Map<String, dynamic>;
                                    //             return Padding(
                                    //               padding: const EdgeInsets.only(top: 20),
                                    //               child: ListTile(
                                    //                 title: Row(
                                    //                   children: [
                                    //                     Text(
                                    //                       driver["latitude"].toString(),
                                    //                       style: TextStyle(fontSize: 16),
                                    //                     ),
                                    //                     SizedBox(
                                    //                       width: 20,
                                    //                     ),
                                    //                     Text(
                                    //                       driver["longitude"].toString(),
                                    //                       style: TextStyle(fontSize: 16),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //                 trailing: IconButton(
                                    //                   icon: Icon(
                                    //                     Icons.directions,
                                    //                     size: 40,
                                    //                     color: Color.fromARGB(255, 20, 15, 15),
                                    //                   ),
                                    //                   onPressed: () {
                                    //                     Navigator.of(context).push(
                                    //                         MaterialPageRoute(
                                    //                             builder: (context) =>
                                    //                                 new MyMap()));
                                    //                   },
                                    //                 ),
                                    //               ),
                                    //             );
                                    //           });
                                    //     },
                                    //   )),
                                    //
                                  ],
                                ),
                              );
                            });
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
