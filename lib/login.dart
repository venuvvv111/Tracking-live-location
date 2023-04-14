// ignore_for_file: unnecessary_new, prefer_const_constructors, avoid_print, sized_box_for_whitespace, library_private_types_in_public_api, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:tracker/screens/location.dart';
import 'package:tracker/screens/first.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email......");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login......");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            // errorStyle: TextStyle(color: Color.fromARGB(255, 216, 210, 202)),
            filled: true,
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 31, 21, 21)),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.white));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFFcffde1),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text.trim(), passwordController.text.trim());
          },
          child: Text(
            "LogIn",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );
    final StudentButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF68b984),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => First()));
          },
          child: Text(
            "I'm a Student",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                          image: AssetImage("images/lname.jpg"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(height: 45),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: emailField),
                  SizedBox(height: 25),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: passwordField),
                  SizedBox(height: 35),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: loginButton),
                  SizedBox(height: 15),
                  Text(
                    'Or',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      child: StudentButton),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DocumentSnapshot? snapshot;
  // login function

  void signIn(String email, String password) async {
    // DocumentSnapshot? snapshot;

    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) => {
                  // snapshot = FirebaseFirestore.instance
                  //     .collection('users')
                  //     .doc(value.user!.uid)
                  //     .get() as DocumentSnapshot<Map<String, dynamic>>,
                  print(value.user!.uid),
                  FirebaseFirestore.instance
                      .collection('drivers')
                      .doc(value.user!.uid)
                      .update({
                    "email": value.user!.email,
                    "uid": FirebaseAuth.instance.currentUser!.uid
                  }),
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Location())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  snap(UserCredential value) {
    return snapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(value.user!.uid)
        .get() as DocumentSnapshot<Object?>;
  }

  void validate() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: "driver1@gmail.com", password: "driverone");
    print("Ashok");
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("drivers").get();
    print("Ashok");
    for (var doc in snapshot.docs) {
      String email = doc["email"].toString();
      String password = doc["password"].toString();
      String name = doc["name"].toString();
      print(email + "+" + name);

      if (emailController.text.toString() == email &&
          passwordController.text.toString() == password) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => ButtonPage(
        //               name: name,
        //             )));
      }
    }
  }
}
