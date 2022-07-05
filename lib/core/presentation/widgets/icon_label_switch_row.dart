import 'package:flutter/material.dart';

class IconLabelSwitchRow extends StatefulWidget {
  final IconData iconData;
  final String label;
  final bool validateForValue;
  final String? Function(String? value)? customValidator;
  final void Function(String? value)? onChanged;

  final bool isSwitched;

  const IconLabelSwitchRow(
      {Key? key,
      required this.iconData,
      required this.label,
        this.isSwitched = false,
      this.validateForValue = true,
      this.customValidator,
      this.onChanged})
      : super(key: key);

  @override
  State<IconLabelSwitchRow> createState() => _IconLabelSwitchRowState();
}

class _IconLabelSwitchRowState extends State<IconLabelSwitchRow> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.isSwitched;
  }

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
              child: Switch(
                activeColor: Theme.of(context).primaryColorLight,
                inactiveTrackColor: Colors.grey,
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ))
        ],
      ),
    );
  }
}
