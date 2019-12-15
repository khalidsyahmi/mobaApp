import 'package:flutter/material.dart';
import 'package:offleaveppkt/home/setting_form.dart';
import 'package:offleaveppkt/services/authenticate.dart'; // lesson 9
import 'package:offleaveppkt/services/database.dart';
import 'package:provider/provider.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offleaveppkt/home/leave_list.dart';
import 'package:offleaveppkt/model/leave.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Leave>>.value(
      value: DatabaseService().leave,
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          title: Text('Home Screen'),
          backgroundColor: Colors.pink[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
             image: AssetImage('assets/google-pixel-3.jpg'),
             fit: BoxFit.cover,
             )
          ),
          child: LeaveList()
        ),
      ),
    );
  }
}
