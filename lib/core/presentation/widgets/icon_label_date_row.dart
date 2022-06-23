import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IconLabelDateRow extends StatefulWidget {
  final IconData iconData;
  final String label;
  final bool validateForValue;
  final TextEditingController dateCtrl;

  const IconLabelDateRow({
    Key? key,
    required this.iconData,
    required this.label,
    required this.dateCtrl,
    this.validateForValue = true,
  }) : super(key: key);

  @override
  State<IconLabelDateRow> createState() => _IconLabelDateRowState();
}

class _IconLabelDateRowState extends State<IconLabelDateRow> {
  final TextEditingController controller = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    DateTime convertedDate = DateFormat('dd.MM.yyy').parse(widget.dateCtrl.text);

    final DateTime? pickedStartDate = await showDatePicker(
        context: context,
        initialDate: convertedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 356 * 20)),
        lastDate: DateTime(2101));
    if (pickedStartDate != null && pickedStartDate != convertedDate) {
      setState(() {
        widget.dateCtrl.text = DateFormat('dd.MM.yyy').format(pickedStartDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          GestureDetector(
            onTap: () => selectDate(context),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(widget.dateCtrl.text,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 18.0))),
          )
        ],
      ),
    );
  }
}
