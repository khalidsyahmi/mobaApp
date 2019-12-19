import 'package:flutter/material.dart';
import 'package:offleaveppkt/model/leave.dart';

class LeaveTile extends StatelessWidget {

  final Leave leave;
  LeaveTile({ this.leave });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0 ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blue[leave.time],
            //backgroundImage: AssetImage('assets/circle-border.jpg'),
          ),
          title: Text(leave.reason),
          subtitle: Text('Leave date: ${leave.date} at time: ${leave.time}'),
        ),
      ),      
    );
  }
}