import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/home.dart';
import '../loginsignup/signup.dart';

// ignore: camel_case_types
class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

// ignore: camel_case_types
class _loginState extends State<login> {
  final _formkey = GlobalKey<FormState> ();
  String _email, _password, _error;


  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: SafeArea (
            child: SingleChildScrollView (
              child: Form (
                key: _formkey,
                child: Column (
                  children: <Widget>[
                    SizedBox (height: 0.5,),
                    alertbox (),
                    SizedBox (height: 0.5,),
                    Padding (
                      padding: EdgeInsets.only (top: 40, bottom: 20),
                      child: IconButton (
                        icon: Icon (
                          Icons.book,
                          color: Colors.blue,
                        ),
                        onPressed: () {

                        },
                        iconSize: 80,
                      ),
                    ),
                    Container (
                      padding: EdgeInsets.only (
                          left: 15, right: 15, bottom: 25),
                      child: TextFormField (
                        obscureText: false,
                        decoration: InputDecoration (
                          prefixIcon: Icon (
                            Icons.email,
                          ),
                          hintText: "Enter your email",
                          labelText: "Email",
                          border: OutlineInputBorder (
                              borderRadius: BorderRadius.circular (100.0)),
                        ),
                        onSaved: (email) {
                          _email = email;
                        },
                        // ignore: missing_return
                        validator: (email) {
                          if (email.isEmpty) {
                            return "Please enter your email!";
                          }
                        },
                      ),
                    ),
                    Container (
                      padding: EdgeInsets.only (
                          left: 15, right: 15, bottom: 25),
                      child: TextFormField (
                        obscureText: true,
                        decoration: InputDecoration (
                          prefixIcon: Icon (
                            Icons.library_books,
                          ),
                          labelText: "Password",
                          hintText: "Enter your password",
                          border: OutlineInputBorder (
                              borderRadius: BorderRadius.circular (100.0)
                          ),
                        ),
                        onSaved: (password) {
                          _password = password;
                        },
                        // ignore: missing_return
                        validator: (password) {
                          if (password.length < 8) {
                            return "Your password must contain atleast 8 characters";
                          }
                        },
                      ),
                    ),
                    RaisedButton (
                      color: Colors.blue,
                      padding: EdgeInsets.only (
                          top: 15, bottom: 15, left: 50, right: 50),
                      child: Text (
                        "Sign in",
                        style: TextStyle (
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                      onPressed: () {
                        signin ();

                      },
                      shape: RoundedRectangleBorder (
                          borderRadius: BorderRadius.circular (50.0)),
                    ),
                    SizedBox (height: 15,),
                    Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text ("Don't have an account?",
                          style: TextStyle (
                              fontSize: 15
                          ),),
                        InkWell (
                          child: Text (
                            "Sign Up",
                            style: TextStyle (
                                color: Colors.blue[700],
                                fontSize: 15
                            ),
                          ),
                          onTap: () {
                            Navigator.push (
                              context,
                              MaterialPageRoute (builder: (context) =>
                                  signup ()),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        )
    );
  }

  Widget alertbox() {
    if (_error != null) {
      return Container (
        color: Colors.amber[900],
        width: double.infinity,
        child: Row (
          children: <Widget>[
            Padding (
              padding: EdgeInsets.all (5.0),
              child: Icon (
                Icons.error_outline,
              ),
            ),
            Expanded (
              child: Text (
                _error, maxLines: 2,
              ),
            ),
            Padding (
                padding: EdgeInsets.all (5.0),
                child: IconButton (
                  icon: Icon (
                    Icons.cancel,
                  ),
                  onPressed: () {
                    Navigator.push (
                      context,
                      MaterialPageRoute (builder: (context) => login ()),
                    );
                  },
                )
            ),

          ],
        ),
      );
    }
    return SizedBox (height: 0,);
  }

  Future<void> signin() async
  {
    final formState = _formkey.currentState;
    if (formState.validate ()) {
      formState.save ();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword (
            email: _email, password: _password);
        final FirebaseUser user = await FirebaseAuth.instance.currentUser ();
        if (user.isEmailVerified) {
          Navigator.push (
            context,
            MaterialPageRoute (builder: (context) => home ()),
          );
        }
        else {
          _showpopup ();
        }
      } catch (e) {
        setState (() {
          _error = e.message;
        });
      }
    }
  }

  void _showpopup() {
    showDialog (
      context: context,
      builder: (BuildContext context) {
        return AlertDialog (
          title: new Text("Account not verified!"),
          content: new Text("Please login to your mail to vrify your account"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of (context).pop ();
              },
            ),
          ],
        );
      },
    );
  }
}