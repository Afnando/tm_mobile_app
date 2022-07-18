//make firebaseCloudStorage a singleton
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tm_mobile_app/services/cloud/cloud_complaint.dart';
import 'package:tm_mobile_app/services/cloud/cloud_storage_constans.dart';
import 'package:tm_mobile_app/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  //talk to firestore
  final log = FirebaseFirestore.instance.collection('complaint');

  //update complaint

  Future<void> updateComplaint({
    required String id,
    // required this.ownerUserId,
    // required String logDate,
    // // required this.month,
    required String stakeholder,
    required String pic,
    required String issues,
    required String actionItem,
    required String rfsi,
    required String owner,
    // required String status,
    // required String dateClosed,
  }) async {
    try {
      await log.doc(id).update({
        // logDateField: logDate,
        stakeholderField: stakeholder,
        picField: pic,
        issuesField: issues,
        actionFIeld: actionItem,
        rfsiField: rfsi,
        ownerField: owner,
        // statusField: status,
        // dateClosedField: dateClosed,
      });
    } catch (e) {
      throw CouldNotUpdateComplaintException();
    }
  }

  // delete document from firestore

  Future<void> deleteComplaint({required String id}) async {
    try {
      await log.doc(id).delete();
    } catch (e) {
      throw CouldNotDeleteComplaintException();
    }
  }

  Future<Iterable<ComplaintLog>> getComplaint() async {
    try {
      return await log.get().then(
            (value) =>
                value.docs.map((doc) => ComplaintLog.fromJson(doc.data())),
          );
    } catch (e) {
      throw CouldNotGetAllComplaintException();
    }
  }
  // //get complaint by user ID
  //   Stream<Iterable<ComplaintLog>> allNotes({required String ownerUserId}) {
  //   final allNotes = log
  //       .where(ownerUserIdField, isEqualTo: ownerUserId)
  //       .snapshots()
  //       .map((event) => event.docs.map((doc) => ComplaintLog.fromSnapshot(doc)));
  //   return allNotes;
  // }

  // // create new complaint
  // void createNewComplaint({required ownerUserId}) async {
  //   await log.add({
  //     ownerUserIdField: ownerUserId,
  //     issuesField: '',
  //     actionFIeld:'',
  //     rfsiField:'',
  //   });
  // }

  // //factory constructor
  // static final FirebaseCloudStorage _shared =
  //     FirebaseCloudStorage._sharedInstance();
  // FirebaseCloudStorage._sharedInstance();
  // factory FirebaseCloudStorage() => _shared;
}
