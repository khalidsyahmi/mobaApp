import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:offleaveppkt/model/leave.dart';
import 'package:offleaveppkt/home/leave_tile.dart';

class LeaveList extends StatefulWidget {
  @override
  _LeaveListState createState() => _LeaveListState();
}

class _LeaveListState extends State<LeaveList> {
  @override
  Widget build(BuildContext context) {

    final leave = Provider.of<List<Leave>>(context) ?? []; //empty array
    // print(leave);

    // for (var doc in leave.documents ) {
    //   print(doc.data);
    // }

    // leave.forEach((leave){
    //   print(leave.reason);
    //   print(leave.date);
    //   print(leave.time);
    // });

    return ListView.builder(
      itemCount: leave.length,
      itemBuilder: (context, index){
        return LeaveTile(leave: leave[index]);
      },
    );

  }

}
