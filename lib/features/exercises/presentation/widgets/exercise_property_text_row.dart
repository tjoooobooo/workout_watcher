import 'package:flutter/material.dart';

class ExercisePropertyTextRow extends StatelessWidget {
  final IconData iconData;
  final String label;
  final TextEditingController controller;
  final bool validateForValue;

  const ExercisePropertyTextRow({
    Key? key,
    required this.iconData, required this.label, required this.controller, this.validateForValue = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 5.0,
          top: 5.0,
          bottom: 5.0
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 20,
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                label,
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white
                ),
              )
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (validateForValue == true && (value == null || value.isEmpty)) {
                    return "";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    hintText: "Bitte eingeben",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary
                    )
                ),
                style: const TextStyle(
                    color: Colors.white
                ),
              )
          )
        ],
      ),
    );
  }
}