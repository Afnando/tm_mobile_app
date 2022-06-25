// //make firebaseCloudStorage a singleton
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tm_mobile_app/services/cloud/cloud_complaint.dart';
// import 'package:tm_mobile_app/services/cloud/cloud_storage_constans.dart';

// class FirebaseCloudStorage {
//   //talk to firestore
//   final log = FirebaseFirestore.instance.collection('complaint');

//   //get complaint by user ID
//     Stream<Iterable<ComplaintLog>> allNotes({required String ownerUserId}) {
//     final allNotes = log
//         .where(ownerUserIdField, isEqualTo: ownerUserId)
//         .snapshots()
//         .map((event) => event.docs.map((doc) => ComplaintLog.fromSnapshot(doc)));
//     return allNotes;
//   }

//   // create new complaint
//   void createNewComplaint({required ownerUserId}) async {
//     await log.add({
//       ownerUserIdField: ownerUserId,
//       issuesField: '',
//       actionFIeld:'',
//       rfsiField:'',
//     });
//   }

//   //factory constructor
//   static final FirebaseCloudStorage _shared =
//       FirebaseCloudStorage._sharedInstance();
//   FirebaseCloudStorage._sharedInstance();
//   factory FirebaseCloudStorage() => _shared;
// }
