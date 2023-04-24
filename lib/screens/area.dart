// ignore_for_file: unused_local_variable, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tracker/screens/buses.dart';

class Area extends StatefulWidget {
  const Area({super.key});

  @override
  State<Area> createState() => _AreaState();
}

class _AreaState extends State<Area> {
  // Future<List<ProductDataModel>> ReadJsonData() async {
  //   final jsondata = await rootBundle.loadString('jsonfile/buses.json');

  //   return json.decode(jsondata);
  // }

  // Future<List<ProductDataModel>> ReadJsonData() async {
  //   final jsonString = await rootBundle.loadString('jsonfile/buses.json');
  //   final jsonMap = json.decode(jsonString);

  //   final productModels =
  //       jsonMap.map((v) => ProductDataModel.fromJson(v)).toList();

  //   return productModels;
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          Container(
            height: size.height / 4,
            decoration: const BoxDecoration(
                color: Color(0xFF344D67),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "HELLO!  NBKRian",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Track your bus \nby selecting your destination',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Image(image: AssetImage('images/logo3.png')),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text(
            'Select Your Destination',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("allbuses").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              return Expanded(
                child: ListView.builder(
                    itemCount:
                        snapshot.data == null ? 0 : snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> citynames =
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;

                      String id = snapshot.data!.docs[index].id;
                      return Card(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(25)),
                        elevation: 10,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        child: ListTile(
                          title: Text(
                            id,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text("data"),
                          leading: const Icon(Icons.location_on),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Buses(cityName: id)));
                          },
                        ),
                      );
                    }),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    ));
  }
}
