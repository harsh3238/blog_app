import 'package:blog_app/Authentication.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({
    this.auth,
    this.onSignedOut,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  //Method Logout

  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
        centerTitle: true,
      ),

      //For displaying all the post for different users

      body: new Container(),

      // Bottom Navigaton Bar
      bottomNavigationBar: new BottomAppBar(
        color: Colors.pinkAccent,
        child: new Container(
          margin: const EdgeInsets.only(left: 70.0, right: 70.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.logout),
                iconSize: 40,
                color: Colors.white,
                onPressed:
                    _logoutUser, //later replace this with logoutUser Method
              ),
              new IconButton(
                icon: new Icon(Icons.add_a_photo),
                iconSize: 40,
                color: Colors.white,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
