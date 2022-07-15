import 'package:flutter/material.dart';

class IconLabelButtonRow extends StatefulWidget {
  final IconData iconData;
  final String label;
  final String buttonLabel;
  final Function onPressed;

  const IconLabelButtonRow(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.buttonLabel,
      required this.onPressed})
      : super(key: key);

  @override
  State<IconLabelButtonRow> createState() => _IconLabelButtonRowState();
}

class _IconLabelButtonRowState extends State<IconLabelButtonRow> {
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
              child: ElevatedButton(
                onPressed: () {
                  widget.onPressed();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorDark)),
                child: Text(
                  widget.buttonLabel,
                  style: const TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
