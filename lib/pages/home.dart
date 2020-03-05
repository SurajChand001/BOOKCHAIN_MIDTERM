import 'package:bookchain/loginsignup/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'newsfeed.dart';
import 'post.dart';
import 'review.dart';
// ignore: camel_case_types
class home extends StatefulWidget {

  @override
  _homeState createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {

  final List<Widget> pages = [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  int _selectedIndex = 0;


  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
    onTap: (int index) => setState(() => _selectedIndex = index),
    currentIndex: selectedIndex,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home), title: Text('Home')),
      BottomNavigationBarItem(
          icon: Icon(Icons.add_box), title: Text('Add Post')),
      BottomNavigationBarItem(
        icon: Icon(Icons.receipt),title: Text("Review"),
      )
    ],
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child:AppBar(
         title: Text(
            "BookChain"
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
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
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

