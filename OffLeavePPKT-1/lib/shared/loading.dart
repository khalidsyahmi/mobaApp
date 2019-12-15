import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100], //bg color of container
      child: Center(
        child: SpinKitCubeGrid(
          color: Colors.pink,
          size: 50.0,
        ),
      ),
    );
  }
}