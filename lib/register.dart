import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  Widget _buildRegisterForm() {
    final _formKey = GlobalKey<FormState>();

    TextEditingController userEmail = new TextEditingController();
    TextEditingController userPassword = new TextEditingController();
    TextEditingController userFirstName = new TextEditingController();
    TextEditingController userLastName = new TextEditingController();
    TextEditingController userConfirmPassword = new TextEditingController();
    
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAFormField(label: "email", controller: userEmail),
          _buildAFormField(label: "first name", controller: userFirstName),
          _buildAFormField(label: "last name", controller: userLastName),
          _buildAFormField(label: "password", controller: userPassword, obscureText: true),
          _buildAFormField(label: "password again", controller: userConfirmPassword),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // Process data
                  _save();
                  Navigator.pushNamed(context, '/Stream');
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Local Register',
      home: Scaffold(
        appBar: AppBar(
            title: Center(child: Text("Register"))
        ),
        body: Column(
          children: <Widget>[_buildRegisterForm()],
        ),
      ),
    );
  }
}

_save() async {
  print ("Hello");
  var db = await openDatabase('envirodata.db');
  List<Map> list = await db.rawQuery('SELECT * FROM Test');
  print("Hello neightbor: ");
  print (list);
}

Widget _buildAFormField({String label, TextEditingController controller, obscureText = false}) {
  const padAmount = 20.0;
  return Padding(
      padding: const EdgeInsets.all(padAmount),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: new InputDecoration(
          hintText: "Enter your $label",
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your $label";
          }
          return null;
        },
      )
  );
}