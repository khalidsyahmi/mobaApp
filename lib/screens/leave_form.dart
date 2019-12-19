import 'package:flutter/material.dart';
import 'package:offleaveppkt/deConstants.dart';
import 'package:offleaveppkt/model/user.dart';
import 'package:provider/provider.dart';
import 'package:offleaveppkt/services/database.dart';


class LeaveForm extends StatefulWidget {

final String title;
LeaveForm(this.title);

  @override
  _LeaveFormState createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {

  // final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // identify our form
  // bool loading = false; 

    // form values
  String _currentMotive;
  String _currentDate2;
  String _currentTime2;

  // date n time Picker values
  DateTime _dateTime;
  TimeOfDay _timeOfDay;

  @override
  Widget build(BuildContext context) {

  final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
            stream: DatabaseService2(uid: user.uid).userData,
            builder: (context, snapshot) {

              UserData userData = snapshot.data;

              return Scaffold(
        appBar: new AppBar(
              title: new Text('Leave Form'),
              backgroundColor: Colors.orange[400],
              elevation: 0.0,
        ),
        body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/3xl.png'),
                fit: BoxFit.cover,
              )),
              child: new Form( 
                key: _formKey,
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center, // try
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(color: Colors.deepOrange[600]),
                        padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                        child: Text(
                          'Update your Motive',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        // initialValue: userData.motive, 
                        decoration: textInputDecoration,
                        validator: (val) => val.isEmpty ? 'Enter a motive' : null,
                        onChanged: (val) => setState(() => _currentMotive = val),
                      ),
                      SizedBox(height: 25.0),

                         Container(
                           decoration: BoxDecoration(color: Colors.deepOrange[600]),
                           child: Text(_dateTime == null ? 'No date picked yet' : _dateTime.toString(),
                           style: TextStyle(fontSize: 18.0, color: Colors.white),
                           ),
                           padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                         ),
                         SizedBox(height: 5.0),
                         RaisedButton(
                           color: Colors.pink[400],
                           child: Text('Pick a date',style: TextStyle(color: Colors.white)
                           ),
                           onPressed: (){
                             showDatePicker(
                               context: context,
                               initialDate: _dateTime == null ? DateTime.now() : _dateTime, // remember last pick
                               firstDate: DateTime(2000),
                               lastDate: DateTime(2077)             
                             ).then((date) {
                               setState(() {
                                 _dateTime = date;
                                 _currentDate2 = _dateTime.toString();
                               });
                             });//onPressed
                           },
                         ),   
                        SizedBox(height: 20.0),

                        Container(
                           decoration: BoxDecoration(color: Colors.deepOrange[600]),
                           child: Text(_timeOfDay == null ? 'No Time picked yet' : _timeOfDay.toString(),
                           style: TextStyle(fontSize: 18.0, color: Colors.white),
                           ),
                           padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                         ),
                         SizedBox(height: 5.0),
                         RaisedButton(
                           color: Colors.pink[400],
                           child: Text('Pick a Time',style: TextStyle(color: Colors.white)
                           ),
                           onPressed: (){
                             showTimePicker(
                               context: context,
                               initialTime: _timeOfDay == null ? TimeOfDay.now() : _timeOfDay, // remember last pick

                             ).then((time) {
                               setState(() {
                                 _timeOfDay = time;
                                 _currentTime2 = _timeOfDay.toString();
                               });
                             });//onPressed
                           },
                         ),   


                      SizedBox(height: 20.0),
                      RaisedButton(
                              color: Colors.pink[400],
                              child: Text('Update',style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await DatabaseService2(uid: user.uid).updateUserData(
                                    _currentMotive ?? userData.motive,
                                    _currentDate2 ?? userData.date2,
                                    _currentTime2 ?? userData.time2
                                  );
                            
                                  print(_currentMotive);
                                  print(_currentDate2);
                                  print(_currentTime2);

                                  leaveFill(context);
                                }
                                  // Navigator.pop(context);
                              }),
                   ]
                ),
              ),
        ),
      );
            }
          );
  } //build method

  void leaveFill(BuildContext context) {

    var alertDialog = AlertDialog(
      title: Text('Application Submmitted'),
      content: Text('Please review your verification later'),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      }
    );
  }

}// class LeaveForm