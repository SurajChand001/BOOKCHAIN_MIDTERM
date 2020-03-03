import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'verify.dart';
// ignore: camel_case_types
class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

// ignore: camel_case_types
class _signupState extends State<signup> {
  String _useremail,_password,_error;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: (){
            Navigator.push (
              context,
              MaterialPageRoute (builder: (context) => login()),
            );
          },
        ),
      ),
        body:SafeArea(
          child: SingleChildScrollView(
            child:Form (
              key: _formkey,
              child:Column (
          children: <Widget>[
            SizedBox(height: 1,),
            alertbox(),
            SizedBox(height: 1,),
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon (
                    Icons.perm_identity,
                  ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular (100.0)
                    ),
                    hintText: "Enter you name",
                ),
                onSaved: (name){
                },
                // ignore: missing_return
                validator: (name)
                {
                  if(name.isEmpty)
                  {
                    return "Please enter your name";
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                obscureText: false,
                decoration: InputDecoration(
                    prefixIcon: Icon (
                      Icons.email,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular (100.0)
                    ),
                    hintText: "Enter you email"
                ),
                onSaved: (email){
                  _useremail=email;
                },
                // ignore: missing_return
                validator: (email)
                {
                  if(email.isEmpty)
                  {
                    return "Please enter your email";
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                obscureText:true,
                decoration: InputDecoration(
                    prefixIcon: Icon (
                      Icons.library_books,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular (100.0)
                    ),
                    hintText: "Enter password"
                ),
                onSaved: (password){
                  _password=password;
                },
                // ignore: missing_return
                validator: (password)
                {
                  if(password.length<8)
                  {
                    return "Password must consist of atleast 8 characters";
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                obscureText:true,
                decoration: InputDecoration(
                    prefixIcon: Icon (
                      Icons.library_books,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular (100.0)
                    ),
                    hintText: "Confirm Password"
                ),
                onSaved: (cpassword){
                },
                // ignore: missing_return
                validator: (cpassword)
                {
                  if(cpassword.length<8)
                  {
                    return "Password do not match";
                  }
                },
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              padding: EdgeInsets.only(left: 50.0,right: 50.0,top: 15,bottom: 15),
              child: Text(
                "Sign up",
                style: TextStyle(
                  color:Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0)),
              onPressed: (){
                _signup();
              },
            )
          ],
        ),
        ),
      ),
    )
    );
  }
  Future<void> _signup() async
  {
    final formState = _formkey.currentState;
    if(formState.validate())
    {
      formState.save();
      try{
        final FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _useremail, password: _password)).user;
        user.sendEmailVerification();
        Navigator.pushReplacement(
             context,
             MaterialPageRoute (builder: (context) =>verified(_useremail)),
           );
      } catch (e) {
        setState(() {
          _error = e.message;
        });
      }
    }
  }
  Widget alertbox(){
    if(_error!=null){
      return Container(
        color: Colors.amber[500],
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.error_outline,
              ),
            ),
            Expanded(
              child: Text(
                _error,maxLines:2,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: IconButton(
                  icon:Icon(
                    Icons.cancel,
                  ),
                  onPressed: (){
                    Navigator.push (
                      context,
                      MaterialPageRoute (builder: (context) => signup()),
                    );
                  },
                )
            ),
          ],
        ),
      );
    }
    return SizedBox(height: 0,);
  }
}