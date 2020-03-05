import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

 StorageReference reference = FirebaseStorage.instance.ref().child("BOOKS");
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              child:ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context,index){

                  }
              )
            )
          ],
        ),
      ),
    );
  }
}
