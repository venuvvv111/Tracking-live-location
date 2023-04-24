// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracker/login.dart';
import 'package:tracker/screens/location.dart';
import 'package:tracker/screens/area.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  final bool _click = false;
  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size;

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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Stack(
                //   children: [
                //     Container(
                //       height: size.height / 1,
                //       width: double.infinity,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.only(
                //               bottomLeft: Radius.circular(20),
                //               bottomRight: Radius.circular(20))),
                //       child: Image(
                //         image: AssetImage('images/college.png'),
                //         fit: BoxFit.fill,
                //       ),
                //     ),
                //     //
                //   ],
                // ),

                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    image: DecorationImage(
                        image: AssetImage("images/lname.jpg"),
                        fit: BoxFit.fill),
                  ),
                ),

                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Area()));
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xFFcffde1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color.fromARGB(255, 48, 38, 38),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                              backgroundColor: Color(0xFF68b984),
                              radius: 18,
                              child: Icon(
                                Icons.person_outlined,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Student',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  (FirebaseAuth.instance.currentUser != null)
                                      ? const Location()
                                      : const LoginScreen()));
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xFFcffde1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color:
                                _click ? Colors.red : const Color(0xFF68b984),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xFF68b984),
                              child: Icon(
                                Icons.drive_eta_rounded,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Driver',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
