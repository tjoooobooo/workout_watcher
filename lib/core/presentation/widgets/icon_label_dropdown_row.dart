import 'package:flutter/material.dart';

class IconLabelDropdownRow extends StatefulWidget {
  final IconData iconData;
  final String label;
  final dynamic initialType;

  final Map<dynamic, String> items;
  final Function changeValueFunc;

  const IconLabelDropdownRow(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.items,
      required this.changeValueFunc,
      this.initialType})
      : super(key: key);

  @override
  State<IconLabelDropdownRow> createState() =>
      _IconLabelDropdownRowState();
}

class _IconLabelDropdownRowState
    extends State<IconLabelDropdownRow> {
  dynamic chosenItemValue;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<dynamic>> dropdownItems = [];
    chosenItemValue = widget.initialType;

    widget.items.forEach((value, label) {
      dropdownItems.add(DropdownMenuItem<dynamic>(
        value: value,
        child: Text(label),
      ));
    });

    return Container(
      padding: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorDark,
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
              child: DropdownButtonFormField<dynamic>(
                items: dropdownItems,
                value: chosenItemValue,
                onChanged: (newValue) {
                  setState(() {
                    chosenItemValue = newValue!;
                    widget.changeValueFunc(newValue);
                  });
                },
                dropdownColor: Theme.of(context).colorScheme.primary,
                validator: (value) {
                  if (value == null || value == "") {
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
