import 'package:flutter/material.dart';

class ExercisePropertyDropdownRow extends StatefulWidget {
  final IconData iconData;
  final String label;
  final String? initialType;

  final Map<String, String> items;
  final Function changeValueFunc;

  const ExercisePropertyDropdownRow(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.items,
      required this.changeValueFunc,
      this.initialType})
      : super(key: key);

  @override
  State<ExercisePropertyDropdownRow> createState() =>
      _ExercisePropertyDropdownRowState();
}

class _ExercisePropertyDropdownRowState
    extends State<ExercisePropertyDropdownRow> {
  String? chosenExerciseType;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    chosenExerciseType = widget.initialType;

    widget.items.forEach((value, label) {
      dropdownItems.add(DropdownMenuItem<String>(
        value: value,
        child: Text(label),
      ));
    });

    return Container(
      padding: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 20,
            child: Icon(
              widget.iconData,
              color: Colors.white,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                widget.label,
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              )),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: DropdownButtonFormField<String>(
                items: dropdownItems,
                value: chosenExerciseType,
                onChanged: (newValue) {
                  setState(() {
                    chosenExerciseType = newValue!;
                    widget.changeValueFunc(newValue);
                  });
                },
                dropdownColor: Theme.of(context).colorScheme.primary,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  } else {
                    return null;
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  hintText: "Bitte wählen",
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
