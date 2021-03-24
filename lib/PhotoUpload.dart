import 'package:flutter/material.dart';

class PhotoUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PhotoUploadState();
  }
}

class _PhotoUploadState extends State<PhotoUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Blog App"),
        centerTitle: true,
      ),
    );
  }
}
