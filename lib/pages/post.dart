import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  File _image;
  String name;
  String bookName,description;
  final db = Firestore.instance;


  // ignore: non_constant_identifier_names
  Future Upload() async{
    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child(bookName);
    final StorageUploadTask task =
    firebaseStorageRef.child(bookName).putFile(_image);
    print('File Uploaded');
  }
  Future getImage(bool isCamera) async {
  File image;
   if(isCamera)
     {
       image = await ImagePicker.pickImage(source: ImageSource.camera);
     }
   else
     {
       image =  await ImagePicker.pickImage(source: ImageSource.gallery);
     }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:SingleChildScrollView(
        child:Center(
       child: Column(
         children: <Widget>[
           Container(
            child: StreamBuilder(
              stream: Firestore.instance.collection('USERS').snapshots(),
              builder: (context,snapshot){
               if(!snapshot.hasData)
                 {
                   return Text("Loading");
                 }
                  return Container( child:Column(
                  children: <Widget>[
                  Text("Welcome ${snapshot.data.documents[1]['Name']}")
                ],
                )
                  );

              },
            ),
           ),
           Container(
             padding: EdgeInsets.all(15.0),
             child: TextFormField(
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 hintText: "Name of the Book",
               ),
               onChanged: (text){
                bookName = text;
               },

             ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 15,bottom: 15,right: 2),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  child: Text(
                    "Take Photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: (){
                    getImage(true);
                  },
                ),
              ),
               Container(
                 padding: EdgeInsets.only(top: 15,bottom: 15,left: 2),
                 child: RaisedButton(
                   color: Colors.blueAccent,
                   child: Text(
                     "Browse Photo",
                     style: TextStyle(
                       color: Colors.white,
                     ),
                   ),
                   onPressed: (){
                     getImage(false);
                   },
                 ),
               ),

             ],
           ),

          SizedBox(
            height: 10,
          ),
          Container(
            child: _image==null? Container():Image.file(_image,height: 300,width: 350,),
          ),
           Container(
             child: RaisedButton(
                 color: Colors.blueAccent,
                 child: Text(
                   "Post",
                   style: TextStyle(
                     color: Colors.white,
                   ),
                 ),
                 onPressed: () {
                  if(_image!=null)
                    {
                      Upload();
                      SnackBar mybar = SnackBar(
                        content: Text("Uploaded"),
                      );
                      Scaffold.of(context).showSnackBar(mybar);
                    }
                  else{
                    SnackBar mybar = SnackBar(
                      content: Text(
                        "Image not selected"
                      ),
                    );
                    Scaffold.of(context).showSnackBar(mybar);
                  }
                 }

             ),
           ),
         ],
       ),
     ),
    ),
    );
  }
}
