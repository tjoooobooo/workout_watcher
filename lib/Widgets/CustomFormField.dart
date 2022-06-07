import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hint,
    required this.errorMsg,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputType = TextInputType.text
  }) : super(key: key);

  final String hint;
  final String errorMsg;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          autofocus: false,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorMsg;
            } else {
              return null;
            }
          },
          style: const TextStyle(
              color: Colors.white
          ),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    width: 2.0,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    width: 2.0,
                  )
              ),
              labelText: hint,
              labelStyle: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
              ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}