import 'package:bookchain/loginsignup/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child:AppBar(
         title: Text(
            "Home"
        ),
      ),
      ),
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child:
              Text(
                "BookChain",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text("About Developer",
                style:
                TextStyle(
                    color: Colors.blue,
                    fontSize: 15
                ),
              ),
              onTap: (){
                //do something
              },
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                color: Colors.blue,
              ),
              ),
              onTap: (
              signout
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
       color: Colors.blue,
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.home, size:25,color: Colors.white,),
          Icon(Icons.dashboard, size: 25,color: Colors.white,),
          Icon(Icons.rate_review, size: 25,color: Colors.white,),
        ],
        onTap: (index) {
        },
      ),
    );
  }
  void signout() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>new login()),
    );
  }
}

