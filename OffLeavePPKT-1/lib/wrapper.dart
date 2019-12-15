import 'package:offleaveppkt/screens/authenticate/auth.dart';
import 'package:offleaveppkt/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // lesson 8
import 'package:offleaveppkt/model/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    //print(user);
    if (user == null){
     // return either the Home or Authenticate widget
     return Authenticate();
      } else{
        return Home(); // to home the home page instead
    }
   
  }
}