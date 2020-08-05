import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_bloc_firebase/signup/view/signup_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageSate();
  }
}

double screenWidth = 0.0;
double listItemHeight = 70.0;

class _HomePageSate extends State<HomePage> {
  Widget _buildContent() {
    return Center(
      child: Container(
          decoration: BoxDecoration(color: Colors.orange),
          child: ListView(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              Material(
                child: Container(
                  decoration: BoxDecoration(color: Colors.orange),
                  width: screenWidth,
                  height: listItemHeight,
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()));
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: 24,
                            color: Colors.orange,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _buildContent(),
    );
  }
}
