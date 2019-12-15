import 'package:flutter/material.dart';
import 'package:offleaveppkt/services/authenticate.dart';
import 'package:offleaveppkt/wrapper.dart';
import 'package:provider/provider.dart'; //lesson 8
import 'package:offleaveppkt/model/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(        // listening data using Stream??
      value: AuthService().user,  
        child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}