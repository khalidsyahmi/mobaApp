import 'package:flutter/material.dart';
import 'package:offleaveppkt/deConstants.dart';
import 'package:offleaveppkt/model/user.dart';
import 'package:offleaveppkt/services/database.dart';
import 'package:offleaveppkt/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> date = ['0', '1', '2', '3', '4'];

  // form values
  String _currentReason;
  String _currentDate;
  int _currentTime;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            UserData userData = snapshot.data;
              return Form(
                key: _formKey,
                child: Column( 
                  children: <Widget>[
                    Text(
                      'Update your status',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.reason, //
                      decoration: textInputDecoration,
                      validator: (val) => val.isEmpty ? 'Enter a reason' : null,
                      onChanged: (val) => setState(() => _currentReason = val),
                    ),
                    SizedBox(height: 20.0),
                    //dropdown ff
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentDate ?? userData.date, //
                      items: date.map((date) {
                        return DropdownMenuItem(
                          value: date,
                          child: Text('date: $date'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentDate = val),
                    ),
                    //slider
                    Slider(
                      value: (_currentTime ?? userData.time).toDouble(), //
                      activeColor: Colors.blue[_currentTime ?? 100],
                      inactiveColor: Colors.blue[_currentTime ?? 100],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentTime = val.round()),
                    ),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                              _currentReason ?? userData.reason,
                              _currentDate ?? userData.date,
                              _currentTime ?? userData.time
                            );
                            Navigator.pop(context);
                          }
                        }),
                  ],
                ),
              );
          } else {
            return Loading();
          }
        });
  }
}
