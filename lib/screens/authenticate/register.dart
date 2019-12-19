import 'package:flutter/material.dart';
import 'package:offleaveppkt/services/authenticate.dart';
import 'package:offleaveppkt/deConstants.dart';
import 'package:offleaveppkt/shared/loading.dart';

 class Register extends StatefulWidget {

   final Function toggleView;
   Register({ this.toggleView });

   @override
   _RegisterState createState() => _RegisterState();
 }
 
 class _RegisterState extends State<Register> {
 
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // identify our form
  bool loading = false; 

  // text field state
  String email = '';
  String password = '';
  String error = ''; //hell yah errors

   @override
   Widget build(BuildContext context) {
         return loading ? Loading() :  Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to PPKT app'),
         actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),  // toggle signin page
            onPressed: () {
              widget.toggleView();
            }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey, // validation technique
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField( 
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null, //validator
                onChanged: (val) {
                  setState(() => email = val);  // tracking
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'), // textbox deco
                obscureText: true, //to obscure password
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    if (_formKey.currentState.validate()){
                      setState(() => loading = true);       // set loading
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if (result == null){
                        setState(() => error = 'please supply a valid email');
                        loading = false;
                      }
                    }
                  },
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        )
      ) 
     );

   }
 }