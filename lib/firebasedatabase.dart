import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tracker/databaseMap.dart';

class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<Map<dynamic, dynamic>> lists = [];

  final ref = FirebaseDatabase.instance.ref('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Tracker'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild: const Text('Fetching Data'),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return ListTile(
                  title: Text("Bus 1"),
                  subtitle: Text('College : NBKRIST'),
                  trailing: IconButton(
                    icon: Icon(Icons.room_outlined),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DatabaseMap(
                                    lat: snapshot.child('lat').value.toString(),
                                    lan: snapshot.child('lon').value.toString(),
                                  )));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
