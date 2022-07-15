import 'package:flutter/material.dart';

class PlanWeekTextInput extends StatelessWidget {
  final String hint;
  final TextInputType textInputType;
  final TextEditingController controller;

  const PlanWeekTextInput({
    required this.hint,
    required this.textInputType,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: textInputType,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
          const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold),
          labelStyle:
          const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusColor: Colors.white,
        ));
  }
}