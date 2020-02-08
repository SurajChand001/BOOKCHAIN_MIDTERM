import 'package:bookchain/loginsignup/login.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class verified extends StatefulWidget {
  verified(this._useremail);
  String _useremail;

  @override
  _verifiedState createState() => _verifiedState(this._useremail);
}

// ignore: camel_case_types
class _verifiedState extends State<verified> {

  _verifiedState(this._useremail);
  String _useremail;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "An email verification",style: TextStyle(fontSize: 20),
            ),
            Text(
              "has been sent to",style: TextStyle(fontSize: 20),
            ),
            Text(
              _useremail,style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10,),
            RaisedButton(
              color: Colors.blue,
              padding: EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Text(
                "Verify",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              // ignore: missing_return
              onPressed: (){
                Navigator.push (
                  context,
                  MaterialPageRoute (builder: (context) => login()),
                );
              },
            )
          ],
        ),
      ),
    );
  }


}
