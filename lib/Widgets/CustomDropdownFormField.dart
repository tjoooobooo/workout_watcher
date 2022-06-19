import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatefulWidget {
  Map<String, String> items;
  String? chosenExerciseType;
  String hint;

  Function changeValueFunc;

  CustomDropdownFormField(
      {Key? key,
      required this.items,
      required this.chosenExerciseType,
      required this.hint,
      required this.changeValueFunc})
      : super(key: key);

  @override
  State<CustomDropdownFormField> createState() {
    return _CustomDropdownFormFieldState();
  }
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  List<DropdownMenuItem<String>> dropdownItems = [];

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = [];

    widget.items.forEach((value, label) {
      dropdownItems.add(DropdownMenuItem<String>(
        value: value,
        child: Text(label),
      ));
    });

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            style: TextStyle(color: Colors.white),
            dropdownColor: Theme.of(context).colorScheme.primary,
            hint: Text(
              widget.hint,
              style: TextStyle(color: Colors.white),
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
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  )),
            ),
          ),
          const SizedBox(height: 10.0)
        ],
      ),
    );
  }
}
