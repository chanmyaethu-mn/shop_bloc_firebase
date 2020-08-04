import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupSuccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupSuccessState();
  }
}

class _SignupSuccessState extends State<SignupSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Success'),
      ),
      body: Center(
        child: Container(
          child: Text(
            'Signup Success',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
