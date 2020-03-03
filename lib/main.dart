import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginsignup/login.dart';
import 'pages/home.dart';


void main()=>runApp(myapp());
// ignore: camel_case_types
class myapp extends StatefulWidget {
  @override
  _myappState createState() => _myappState();
}

// ignore: camel_case_types
class _myappState extends State<myapp> {
  var user = FirebaseAuth.instance.currentUser;

  // ignore: non_constant_identifier_names
  Widget default_home = login();

  @override
  Widget build(BuildContext context) {
    if(user!=null)
      {
        default_home = home();
      }
    return MaterialApp(
      title: "BookChain",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:login(),
    );
  }
}
