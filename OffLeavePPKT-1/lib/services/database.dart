import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offleaveppkt/model/leave.dart';
import 'package:offleaveppkt/model/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

// collection referrence
  final CollectionReference leaveCollection =
      Firestore.instance.collection('leave');

//ref docs and updatedata
  Future updateUserData(String reason, String date, int time) async {
    return await leaveCollection.document(uid).setData({
      //map
      'reason': reason,
      'date': date, 
      'time': time,
    });
  }

  //Leave list from snapshot
  List<Leave> _leaveListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Leave(
        reason: doc.data['reason'] ?? '',
        date: doc.data['date'] ?? '-',
        time: doc.data['time'] ?? 0
      );
    }).toList();
  }

  //user data from snapshots
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      reason: snapshot.data['reason'],
      date: snapshot.data['date'], 
      time: snapshot.data['time']
    );
  }

  //get leave stream 
  Stream<List<Leave>> get leave {
    return leaveCollection.snapshots()
    .map(_leaveListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return leaveCollection.document(uid).snapshots()
    .map(_userDataFromSnapShot);
  }

}
