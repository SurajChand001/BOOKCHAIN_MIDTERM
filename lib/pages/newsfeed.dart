import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  StorageReference reference1 = FirebaseStorage.instance.ref().child("BOOKS").child("Alchemist");
  StorageReference reference2 = FirebaseStorage.instance.ref().child("BOOKS").child("Cat");

  String url,url2;
  @override
  Widget build(BuildContext context) {
    getImageUrl();
    getImageUrl2();

    if(url!=null)
      {
        return Scaffold (
          body: ListView(
            primary: false,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
          Container(

            child:SingleChildScrollView(child:Column(
              children: <Widget>[
                Image.network(url,height: 300,width:400),
                StreamBuilder(

                  stream: Firestore.instance.collection('USERS').snapshots(),
                  builder: (context,snapshot){
                    return Container( child:Column(
                      children: <Widget>[
                        Text("Posted by ${snapshot.data.documents[0]['Name']}")                  // USernamefrom the database
                      ],
                    )
                    );

                  },
                ),
                RaisedButton(
                  child: Text("GET",
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  color: Colors.blueAccent,
                  onPressed: (){
                    },
                )
              ],
            )
            )
          ),
              Container(
                  child:SingleChildScrollView(child:Column(
                    children: <Widget>[
                      Image.network(url2,height: 300,width:400),
                      StreamBuilder(

                        stream: Firestore.instance.collection('USERS').snapshots(),
                        builder: (context,snapshot){
                          return Container( child:Column(
                            children: <Widget>[
                              Text("Posted by ${snapshot.data.documents[0]['Name']}")                  // USernamefrom the database
                            ],
                          )
                          );

                        },
                      ),
                      RaisedButton(
                        child: Text("GET",
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        color: Colors.blueAccent,
                        onPressed: (){
                        },
                      )
                    ],
                  )
                  )
              ),

            ],
          )
        );
      }
    else{
      return Container(
        child: Center(
          child:Text(
            "No Data !"
          )
        ),
      );
    }
  }
  void getImageUrl()async{
    url = await reference1.getDownloadURL() as String;
  }
  void getImageUrl2()async{
    url2 = await reference2.getDownloadURL() as String;
  }

}
