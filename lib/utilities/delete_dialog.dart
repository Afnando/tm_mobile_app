import 'package:flutter/material.dart';
import 'package:tm_mobile_app/utilities/generic_dialog.dart';

Future<bool> shoDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this complaint?',
    optionBuilder: () => {
      'Cancel': false,
      'Yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
