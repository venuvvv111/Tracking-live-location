// ignore: unused_import
// ignore_for_file: non_constant_identifier_names, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracker/studentMap.dart';

class Buses extends StatefulWidget {
  final String cityName;
  const Buses({
    super.key,
    required this.cityName,
  });

  @override
  State<Buses> createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String cityName = widget.cityName;
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
                      'Select your bus by \nchoosing the route',
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
            'Choose your bus',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("allbuses")
              .doc(cityName)
              // ignore: prefer_interpolation_to_compose_strings
              .collection(cityName.toLowerCase() + "buses")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData && snapshot.data != null) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> BusDetails =
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                        return Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          StudentMap(bus: BusDetails["id"])));
                            },
                            leading: CircleAvatar(
                              child: Text(
                                BusDetails["id"],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              radius: 26,
                              backgroundColor: const Color(0xFF344D67),
                            ),
                            title: Text(
                              BusDetails['regno'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(BusDetails['destination']),
                            tileColor: Colors.white,
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
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
    ));
  }

  // Future<List<ProductDataModel>> ReadJsonData() async {
  //   String jsondata =
  //       await DefaultAssetBundle.of(context).loadString('jsonfile/buses.json');
  //   List list = json.decode(jsondata) as List<dynamic>;
  //   List<ProductDataModel> productdatamodel =
  //       list.map((e) => ProductDataModel.fromJson(e)).toList();
  //   return productdatamodel;
  // }
}
