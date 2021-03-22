import 'dart:html';

import 'package:flutter/material.dart';
import 'HomePage.dart';

class LoginRegisterPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

enum FormType { login, register }

class _LoginRegisterState extends State<LoginRegisterPage> {
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  //methods
  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Blog App"),
        centerTitle: true,
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createInputs() + createButtons(),
            )),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      //For Logo
      SizedBox(
        height: 10.0,
      ),
      logo(), //Here Logo Widget Is Called.

      //For Spacing Email.
      SizedBox(
        height: 20.0,
      ),

      new TextFormField(
          decoration: new InputDecoration(labelText: 'Email'),
          validator: (value) {
            return value.isEmpty ? 'Email is Required' : null;
          },
          onSaved: (value) {
            return _email = value;
          }),

      //For Spacing Password.
      SizedBox(
        height: 10.0,
      ),
      new TextFormField(
          maxLength: 15,
          decoration: new InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) {
            return value.isEmpty ? 'Password is Required' : null;
          },
          onSaved: (value) {
            return _password = value;
          }),

      //For Buttons.
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget logo() {
    return new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50.0,
        child: Image.asset('assets/images/Blog.PNG'),
      ),
    );
  }

  List<Widget> createButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text(
            "Login",
            style: new TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.pink,
          //onPressed: validateAndSave,

          // for temporary mapping later On Replace with above OnPressed.
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
        new FlatButton(
          child: new Text(
            "Not have an Account? Create Account",
            style: new TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.red,
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text(
            "Create Account",
            style: new TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.pink,
          onPressed: validateAndSave,
        ),
        new FlatButton(
          child: new Text(
            "Already have an Account? Login",
            style: new TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.red,
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
