import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;
  const MyAlertBox(
      {super.key,
      required this.onSave,
      required this.onCancel,
      required this.controller,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        maxLength: 50,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightGreen),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: onSave,
              color: Colors.green,
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: onCancel,
              color: Colors.green,
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
