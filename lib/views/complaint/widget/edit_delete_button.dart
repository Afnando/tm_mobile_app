import 'package:flutter/material.dart';
import 'package:tm_mobile_app/constants/routes.dart';
import 'package:tm_mobile_app/services/cloud/cloud_complaint.dart';
import 'package:tm_mobile_app/utilities/delete_dialog.dart';
import 'package:tm_mobile_app/views/complaint/complaint_edit.dart';

typedef LogCallback = void Function(ComplaintLog log);

class EditDeleteButton extends StatelessWidget {
  final List<ComplaintLog> logs;
  final LogCallback onDeleteLog;
  final int index;

  const EditDeleteButton(
      {Key? key,
      required this.logs,
      required this.onDeleteLog,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final log = logs.elementAt(index);
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => EditFormView(log: log)),
              (route) => false),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            // await _logService.deleteComplaint(id: complaintLog[index].id),
            final shouldDelete = await showDeleteDialog(context);
            if (shouldDelete) {
              onDeleteLog(log);
            }
          },
        ),
      ],
    );
  }
}
