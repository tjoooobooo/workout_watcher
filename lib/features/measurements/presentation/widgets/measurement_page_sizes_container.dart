import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_text_row.dart';

class MeasurementSizesContainer extends StatelessWidget {
  const MeasurementSizesContainer({
    Key? key,
    required this.shouldersCtrl,
    required this.chestCtrl,
    required this.coreCtrl,
    required this.buttCtrl,
    required this.lQuadCtrl,
    required this.rQuadCtrl,
    required this.lArmCtrl,
    required this.rArmCtrl,
    required this.lCalvesCtrl,
    required this.rCalvesCtrl,
  }) : super(key: key);

  final TextEditingController shouldersCtrl;
  final TextEditingController chestCtrl;
  final TextEditingController coreCtrl;
  final TextEditingController buttCtrl;
  final TextEditingController lQuadCtrl;
  final TextEditingController rQuadCtrl;
  final TextEditingController lArmCtrl;
  final TextEditingController rArmCtrl;
  final TextEditingController lCalvesCtrl;
  final TextEditingController rCalvesCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(5.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          const Text(
            "Umfänge",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Column(children: [
            IconLabelTextRow(
              iconData: FontAwesomeIcons.ruler,
              label: "Schultern",
              controller: shouldersCtrl,
              keyboardType: TextInputType.number,
              suffixText: "cm",
            ),
            IconLabelTextRow(
              iconData: FontAwesomeIcons.ruler,
              label: "Brust",
              controller: chestCtrl,
              keyboardType: TextInputType.number,
              suffixText: "cm",
            ),
            IconLabelTextRow(
              iconData: FontAwesomeIcons.ruler,
              label: "Bauch",
              controller: coreCtrl,
              keyboardType: TextInputType.number,
              suffixText: "cm",
            ),
            IconLabelTextRow(
              iconData: FontAwesomeIcons.ruler,
              label: "Po",
              controller: buttCtrl,
              keyboardType: TextInputType.number,
              suffixText: "cm",
            ),
            IconLabelTextRow(
              iconData: FontAwesomeIcons.ruler,
              label: "linker Quad",
              controller: lQuadCtrl,
              keyboardType: TextInputType.number,
              suffixText: "cm",
            ),
            IconLabelTextRow(
              iconData: FontAwesomeIcons.ruler,
              label: "rechter Quad",
              controller: rQuadCtrl,
              keyboardType: TextInputType.number,
              suffixText: "cm",
            ),
            IconLabelTextRow(
              iconData: FontAwesomeIcons.ruler,
              label: "linker Arm",
              controller: lArmCtrl,
              keyboardType: TextInputType.number,
              suffixText: "cm",
            ),
            IconLabelTextRow(
              iconData: FontAwesomeIcons.ruler,
              label: "rechter Arm",
              controller: rArmCtrl,
              keyboardType: TextInputType.number,
              suffixText: "cm",
            ),
            IconLabelTextRow(
              iconData: FontAwesomeIcons.ruler,
              label: "linke Wade",
              controller: lCalvesCtrl,
              keyboardType: TextInputType.number,
              suffixText: "cm",
            ),
            IconLabelTextRow(
              iconData: FontAwesomeIcons.ruler,
              label: "rechter Wade",
              controller: rCalvesCtrl,
              keyboardType: TextInputType.number,
              suffixText: "cm",
            )
          ]),
        ]));
  }
}