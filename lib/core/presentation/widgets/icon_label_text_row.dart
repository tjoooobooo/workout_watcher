import 'package:flutter/material.dart';

class IconLabelTextRow extends StatelessWidget {
  final IconData iconData;
  final String label;
  final TextEditingController controller;
  final bool validateForValue;
  final TextInputType keyboardType;
  final String? Function(String? value)? customValidator;
  final void Function(String? value)? onChanged;
  final String? suffixText;

  const IconLabelTextRow(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.controller,
      this.validateForValue = true,
      this.keyboardType = TextInputType.text,
      this.customValidator,
      this.onChanged,
      this.suffixText})
      : super(key: key);

  String? deleteSuffix(String? value) {
    if (value != null && suffixText != null && customValidator != null) {
      String cleanVal = value.trim().replaceAll(suffixText!, "");
      return customValidator!(cleanVal);
    } else if (customValidator != null) {
      return customValidator!(value);
    }
    return null;
  }

  void buildValueWithSuffix(String value) {
    if (suffixText != null) {
      String valueWithoutSuffix = value.trim().replaceAll(suffixText!, "");
      if (value.endsWith(suffixText!) == false && valueWithoutSuffix.isNotEmpty) {
        int offset = controller.text.length;
        controller.text += " $suffixText";
        controller.selection = TextSelection.collapsed(offset: offset);
      } else if (valueWithoutSuffix.isEmpty) {
        controller.text = "";
        controller.selection = const TextSelection.collapsed(offset: 0);
      }
    }
  }

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorDark,
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
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              )),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                validator: (value) => deleteSuffix(value),
                onChanged: (value) {
                  buildValueWithSuffix(value);

                  // execute onChanged if given
                  if (onChanged != null) {
                    onChanged!(value);
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
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
