import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String helperText;
  final int minLines;
  final int maxLines;
  final Function onEditingComplete;

  CustomTextField(
      {this.controller,
      this.hintText,
      this.helperText,
      this.maxLines,
      this.minLines,
      this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: controller,
      decoration: InputDecoration(
          // disabledBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText ?? '',
          helperText: (helperText ?? '').toUpperCase(),
          helperStyle: TextStyle(fontSize: 13, color: Colors.white38),
          hintStyle: TextStyle(fontSize: 20, color: Colors.white54)),
      keyboardType: TextInputType.emailAddress,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white),
      onEditingComplete: onEditingComplete,
    );
  }
}
