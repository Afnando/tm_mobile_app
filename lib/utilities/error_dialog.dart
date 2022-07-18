import 'package:flutter/material.dart';
import 'package:tm_mobile_app/utilities/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'An Error Occured',
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
