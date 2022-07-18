import 'package:flutter/material.dart';
import 'package:tm_mobile_app/utilities/generic_dialog.dart';

Future<void> showAddUpdateDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'Success',
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
