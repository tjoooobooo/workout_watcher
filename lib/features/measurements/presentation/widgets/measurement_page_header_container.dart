import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_date_row.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_text_row.dart';
import 'package:workout_watcher/core/util/text_formfield_validator.dart';

class MeasurementHeaderContainer extends StatelessWidget {
  const MeasurementHeaderContainer({
    Key? key,
    required this.dateCtrl,
    required this.kfaCtrl,
    required this.bodyWeightCtrl,
  }) : super(key: key);

  final TextEditingController dateCtrl;
  final TextEditingController kfaCtrl;
  final TextEditingController bodyWeightCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(5.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Column(
            children: [
              IconLabelDateRow(
                iconData: Icons.calendar_today_rounded,
                label: "Datum",
                dateCtrl: dateCtrl,
              ),
              IconLabelTextRow(
                iconData: Icons.percent,
                label: "KFA",
                controller: kfaCtrl,
                keyboardType: TextInputType.number,
                suffixText: "%",
                customValidator: (value) =>
                    doubleBetweenValidator(value, 3, 50),
              ),
              IconLabelTextRow(
                iconData: FontAwesomeIcons.weightScale,
                label: "Gewicht",
                controller: bodyWeightCtrl,
                keyboardType: TextInputType.number,
                suffixText: "kg",
                customValidator: (value) =>
                    doubleBetweenValidator(value, 40, 250),
              )
            ],
          )
        ]));
  }
}
