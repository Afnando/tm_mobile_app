// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/foundation.dart';
// import 'package:tm_mobile_app/services/cloud/cloud_storage_constans.dart';

// @immutable
// complaint class
// things must contain = primary key/uid, field
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintLog {
  String id;
  // final String ownerUserId;
  final String logDate;
  // final DateTime month;
  final String stakeholder;
  final String pic;
  final String issues;
  final String actionItem;
  final String rfsi;
  final String owner;
  final DateTime dateClosed;

  ComplaintLog({
    this.id = '',
    // required this.ownerUserId,
    required this.logDate,
    // required this.month,
    required this.stakeholder,
    required this.pic,
    required this.issues,
    required this.actionItem,
    required this.rfsi,
    required this.owner,
    required this.dateClosed,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'logDate': logDate,
        // 'month': month,
        'stakeholder': stakeholder,
        'pic': pic,
        'issues': issues,
        'action': actionItem,
        'rfsi': rfsi,
        'owner': owner,
        'dateClosed': dateClosed,
      };

  static ComplaintLog fromJson(Map<String, dynamic> json) => ComplaintLog(
        id: json['id'],
        logDate: json['logDate'],
        stakeholder: json['stakeholder'],
        pic: json['pic'],
        issues: json['issues'],
        actionItem: json['action'],
        rfsi: json['rfsi'],
        owner: json['owner'],
        dateClosed: (json['dateClosed'] as Timestamp).toDate(),
      );
  // // constructor to call snapshot of complaintLog
  // ComplaintLog.fromSnapshot(
  //     QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
  //     : id = snapshot.id,
  //       ownerUserId = snapshot.data()[ownerUserIdField],
  //       logDate = snapshot.data()[logDateField] as DateTime,
  //       //  month;
  //       //  stakeholder;
  //       //  pic;
  //       issues = snapshot.data()[issuesField] as String,
  //       actionItem = snapshot.data()[actionFIeld] as String,
  //       rfsi = snapshot.data()[rfsiField] as String,
  //       //  owner;
  //       dateClosed = snapshot.data()[dateClosedField] as DateTime;
}
