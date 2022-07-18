import 'package:flutter/material.dart';

// reusable textformfield widget
Widget makeInput({label, controller, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 7),
      TextFormField(
        controller: controller,
        minLines: 1,
        maxLines: 5,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 5,
            ),
          ),
          prefixIcon: Icon(Icons.format_list_bulleted_rounded),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: (String? val) {
          controller = val;
        },
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )
    ],
  );
}
