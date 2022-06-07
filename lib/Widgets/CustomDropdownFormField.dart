import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatefulWidget {
  Map<String, String> items;
  String? chosenExerciseType;
  String hint;

  Function changeValueFunc;

  CustomDropdownFormField({
    required this.items,
    required this.chosenExerciseType,
    required this.hint,
    required this.changeValueFunc
  });


  @override
  State<CustomDropdownFormField> createState() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    items.forEach((value, label) {
      dropdownItems.add(
          DropdownMenuItem<String>(
            value: value,
            child: Text(label),
          )
      );
    });

    return _CustomDropdownFormFieldState(dropdownItems: dropdownItems);
  }
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  List<DropdownMenuItem<String>> dropdownItems;

  _CustomDropdownFormFieldState({required this.dropdownItems});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        DropdownButtonFormField<String>(
          style: TextStyle(
              color: Colors.white
          ),
          dropdownColor: Theme.of(context).colorScheme.primary,
          hint: Text(
            widget.hint,
            style: TextStyle(
                color: Colors.white
            ),
          ),
          onChanged: (newValue) {
            setState(() {
              widget.chosenExerciseType = newValue!;
              widget.changeValueFunc(newValue);
            });
          },
          value: widget.chosenExerciseType,
          items: dropdownItems,
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
          ),
        ),
        SizedBox(height: 10.0)
      ],
    );
  }
}