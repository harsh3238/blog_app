import 'PhotoUpload.dart';
import 'package:blog_app/Authentication.dart';
import 'package:flutter/material.dart';
import 'Posts.dart';
import 'package:firebase_database/firebase_database.dart';

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
  List<Posts> postsList = [];

  @override
  void initState() {
    super.initState();

    DatabaseReference postRef =
        FirebaseDatabase.instance.reference().child("Posts");

    postRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postsList.clear();

      for (var individualKey in KEYS) {
        Posts posts = new Posts(
          DATA[individualKey]['image'],
          DATA[individualKey]['description'],
          DATA[individualKey]['date'],
          DATA[individualKey]['time'],
        );
        postsList.add(posts);
      }

      setState(() {
        print('Length : $postsList.length');
      });
    });
  }

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

      body: new Container(
        child: postsList.length == 0
            ? new Text("No Blog Post Available")
            : new ListView.builder(
                itemCount: postsList.length,
                itemBuilder: (_, index) {
                  return PostsUI(
                      postsList[index].image,
                      postsList[index].description,
                      postsList[index].date,
                      postsList[index].time);
                }),
      ),

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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new UploadPhotoPage();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget PostsUI(String image, String description, String date, String time) {
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: new Container(
        padding: new EdgeInsets.all(14.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                new Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            new Image.network(
              image,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10.0,
            ),
            new Text(
              description,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
