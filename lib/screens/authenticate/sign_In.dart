//import 'package:offleaveppkt/screens/authenticate/auth.dart';
import 'package:flutter/material.dart';
import 'package:offleaveppkt/services/authenticate.dart';
import 'package:offleaveppkt/deConstants.dart';
import 'package:offleaveppkt/shared/loading.dart'; //Loading stuff

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // identify our form
  bool loading = false; // set to true

  //field state values
  String email = '';
  String password = '';
  String error = ''; //hell yah errors

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            //Loading widget first
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to PPKT app'),
              actions: <Widget>[
                FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Sign Up'), // toggle signup page
                    onPressed: () {
                      widget.toggleView();
                    })
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[

                      // block comment this if the build needs flutter clean everytime
                      Material(
                            child: Image.asset('assets/logo_usm.png',
                            width: 200, height: 80),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'PPKT Form App',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null, //validator
                        onChanged: (val) {
                          setState(() => email = val); // tracking
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true, //to obscure password
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true); // set loading
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() => error =
                                  'Cannot Sign in. Credentials are wrong');
                              loading = false; //setback
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )
              ),
          );
  }
}
