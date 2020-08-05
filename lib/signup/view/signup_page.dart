import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_bloc_firebase/common/loading.dart';
import 'package:shop_bloc_firebase/common/model/user.dart';
import 'package:shop_bloc_firebase/common/utils.dart';
import 'package:shop_bloc_firebase/signup/bloc/bloc.dart';
import 'package:shop_bloc_firebase/signup/view/signup_success.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SignupBloc _signupBloc = SignupBloc();

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  final FocusNode _nameFn = FocusNode();
  final FocusNode _phoneFn = FocusNode();
  final FocusNode _pwdFn = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _signupBloc.close();
  }

  void _onTapSignupBtn() {
    final name = _nameController.text ?? '';
    final phoneNumber = _phoneController.text ?? '';
    final plainPwd = _passwordController.text ?? '';

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String hashPassword = computeMD5Hash(plainPwd);
      User user = new User(
          phoneNumber: phoneNumber, userName: name, password: hashPassword);
      _signupBloc.add(SignupBtnEvent(user));
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  Widget _buildSignupBtn() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xfffe8f01),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _onTapSignupBtn();
        },
        child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: _signupBloc,
        listener: (BuildContext context, SignupState state) {
          if (state is SignupSuccessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupSuccess()));
          }
        },
        child: BlocBuilder<SignupBloc, SignupState>(
          bloc: _signupBloc,
          builder: (context, state) {
            if (state is SignupFailState) {
              Fluttertoast.showToast(msg: "Signup Fail");
            }

            final bodyContent = Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.fill),
              ),
              child: SingleChildScrollView(
                child: Container(
                    child: Form(
                      key: _formKey,
                      autovalidate: _validate,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 50),
                                    child: Center(
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontSize:
                                              MediaQuery.of(context).size.width /
                                                  18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width:
                                        MediaQuery.of(context).size.width / 2,
                                        height:
                                        MediaQuery.of(context).size.height / 6,
                                        child: Image(
                                          image: new AssetImage(
                                              'assets/images/logo.png'),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: _nameController,
                                          focusNode: _nameFn,
                                          validator: (value) {
                                            if (value.length == 0) {
                                              return 'Please enter you name';
                                            } else {
                                              return null;
                                            }
                                          },
                                          autofocus: false,
                                          onFieldSubmitted: (field) {
                                            _fieldFocusChange(
                                                context, _nameFn, _phoneFn);
                                          },
                                          decoration: new InputDecoration(
                                              labelText: 'Shop/ Your full Name'),
                                          obscureText: false,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value.length == 0) {
                                              return 'Please enter phone number';
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: _phoneController,
                                          focusNode: _phoneFn,
                                          onFieldSubmitted: (field) {
                                            _fieldFocusChange(
                                                context, _phoneFn, _pwdFn);
                                          },
                                          decoration: new InputDecoration(
                                              labelText: 'Phone'),
                                          obscureText: false,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value.length == 0) {
                                        return 'Please enter your password';
                                      } else {
                                        return null;
                                      }
                                    },
                                    focusNode: _pwdFn,
                                    onFieldSubmitted: (field) {
                                      _pwdFn.unfocus();
                                    },
                                    decoration:
                                    new InputDecoration(labelText: 'Password'),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                _buildSignupBtn(),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      ' Already Have an Account?',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.orange, fontSize: 18),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            );

            return Stack(
              children: <Widget>[
                bodyContent,
                state is SignupLoadingState ? Loading() : new Container(),
              ],
            );
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}