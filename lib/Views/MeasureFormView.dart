import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_watcher/Models/Measurement.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class MeasureFormView extends StatefulWidget {
  Measurement? measurement;

  MeasureFormView({this.measurement});

  @override
  State<MeasureFormView> createState() => _MeasureFormView(measurement: measurement);
}


class _MeasureFormView extends State<MeasureFormView> {
  Measurement? measurement;

  _MeasureFormView({this.measurement});

  DateTime measureDate = DateTime.now();

  final formGlobalKey = GlobalKey < FormState > ();
  final TextEditingController weightCtrl = TextEditingController();
  final TextEditingController kfaCtrl = TextEditingController();
  final TextEditingController shouldersCtrl = TextEditingController();
  final TextEditingController chestCtrl = TextEditingController();
  final TextEditingController coreCtrl = TextEditingController();
  final TextEditingController buttCtrl = TextEditingController();
  final TextEditingController lQuadCtrl = TextEditingController();
  final TextEditingController rQuadCtrl = TextEditingController();
  final TextEditingController lArmCtrl = TextEditingController();
  final TextEditingController rArmCtrl = TextEditingController();
  final TextEditingController lCalvesCtrl = TextEditingController();
  final TextEditingController rCalvesCtrl = TextEditingController();


  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
        context: context,
        initialDate: measureDate,
        firstDate: DateTime.now().subtract(const Duration(days: 356 * 20)),
        lastDate: DateTime(2101));
    if (pickedStartDate != null && pickedStartDate != measureDate) {
      setState(() {
        measureDate = pickedStartDate;
      });
    }
  }

  // return double value if field is filled if not return null
  double? getValue(TextEditingController ctrl) {
    return ctrl.text.isEmpty ?
        null :
        double.parse(ctrl.text.replaceAll(",", "."))
    ;
  }

  @override
  Widget build(BuildContext context) {
    // pre fill fields
    if (measurement != null) {
      weightCtrl.text = measurement!.weight.toString();
      kfaCtrl.text = measurement!.kfa.toString();
      shouldersCtrl.text = measurement!.shoulders == null ? "" : measurement!.shoulders.toString();
      chestCtrl.text = measurement!.chest == null ? "" : measurement!.chest.toString();
      coreCtrl.text = measurement!.core == null ? "" : measurement!.core.toString();
      buttCtrl.text = measurement!.butt == null ? "" : measurement!.butt.toString();
      rQuadCtrl.text = measurement!.rQuads == null ? "" : measurement!.rQuads.toString();
      lQuadCtrl.text = measurement!.lQuads == null ? "" : measurement!.lQuads.toString();
      rArmCtrl.text = measurement!.rArms == null ? "" : measurement!.rArms.toString();
      lArmCtrl.text = measurement!.lArms == null ? "" : measurement!.lArms.toString();
      rCalvesCtrl.text = measurement!.rCalves == null ? "" : measurement!.rCalves.toString();
      lCalvesCtrl.text = measurement!.lCalves == null ? "" : measurement!.lCalves.toString();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            measurement == null ? "Messung hinzufügen" : "Messung"
          ),
          actions: <Widget>[
            if (measurement == null) IconButton(
                icon: const Icon(Icons.save),
                tooltip: "Messung speichern",
                onPressed: () async {
                  if (formGlobalKey.currentState!.validate()) {
                    await FirebaseHandler.addMeasurement(
                        Measurement(
                            date: measureDate,
                            weight: getValue(weightCtrl)!,
                            kfa: getValue(kfaCtrl)!,
                            shoulders: getValue(shouldersCtrl),
                            chest: getValue(chestCtrl),
                            core: getValue(coreCtrl),
                            butt: getValue(buttCtrl),
                            rQuads: getValue(rQuadCtrl),
                            lQuads: getValue(lQuadCtrl),
                            rArms: getValue(rArmCtrl),
                            lArms: getValue(lArmCtrl),
                            rCalves: getValue(rCalvesCtrl),
                            lCalves: getValue(lCalvesCtrl),
                        )
                    );

                    Navigator.of(context).pop();
                  }
                }
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(5.0),
              color: Colors.black,
              child: Form(
                key: formGlobalKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Datum",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          GestureDetector(
                            onTap: () => selectDate(context),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0
                              ),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .primary
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      Icons.date_range,
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                    padding: const EdgeInsets.all(5.0),
                                  ),
                                  const Padding(padding: EdgeInsets.all(2)),
                                  Text(
                                    DateFormat('dd.MM.yyy').format(
                                        measureDate),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.all(2))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TwoFieldsRow(
                        firstText: "Gewicht",
                        firstSuffix: "kg",
                        firstCtrl: weightCtrl,
                        validateFirst: true,
                        secondText: "KFA",
                        secondSuffix: "%",
                        secondCtrl: kfaCtrl,
                        validateSecond: true,
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        color: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.all(5.0),
                        child: const Text(
                          "Umfänge",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TwoFieldsRow(
                          firstText: "Schultern",
                          secondText: "Brust",
                          firstCtrl: shouldersCtrl,
                          secondCtrl: chestCtrl
                      ),
                      const SizedBox(height: 20.0),
                      TwoFieldsRow(
                          firstText: "Bauch    ",
                          secondText: "Po",
                          firstCtrl: coreCtrl,
                          secondCtrl: buttCtrl
                      ),
                      const SizedBox(height: 10.0),
                      TwoFieldsRow(
                          firstText: "l. Quad  ",
                          secondText: "r. Quad",
                          firstCtrl: lQuadCtrl,
                          secondCtrl: rQuadCtrl
                      ),
                      const SizedBox(height: 10.0),
                      TwoFieldsRow(
                          firstText: "l. Arm   ",
                          secondText: "r. Arm",
                          firstCtrl: lArmCtrl,
                          secondCtrl: rArmCtrl
                      ),
                      const SizedBox(height: 10.0),
                      TwoFieldsRow(
                          firstText: "l. Wade  ",
                          secondText: "r. Wade",
                          firstCtrl: lCalvesCtrl,
                          secondCtrl: rCalvesCtrl
                      )
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
}

class TwoFieldsRow extends StatelessWidget {
  TwoFieldsRow({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.firstCtrl,
    required this.secondCtrl,
    this.firstSuffix = "cm",
    this.secondSuffix = "cm",
    this.validateFirst = false,
    this.validateSecond = false,
  }) : super(key: key);

  final String firstText;
  final String secondText;
  String firstSuffix;
  String secondSuffix;
  bool validateFirst;
  bool validateSecond;
  final TextEditingController firstCtrl;
  final TextEditingController secondCtrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          firstText,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        Container(
          width: 90,
          child: TextFormField(
              controller: firstCtrl,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (validateFirst && value!.isEmpty) {
                  return "Bitte füllen";
                } else {
                  return null;
                }
              },
              style: const TextStyle(
                  color: Colors.white
              ),
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
                suffix: Text(
                  firstSuffix,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
          ),
        ),
        Text(
          secondText,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        Container(
          width: 90,
          child: TextFormField(
              controller: secondCtrl,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (validateSecond && value!.isEmpty) {
                  return "Bitte füllen";
                } else {
                  return null;
                }
              },
              style: const TextStyle(
                  color: Colors.white
              ),
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
                suffix: Text(
                  secondSuffix,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
          ),
        ),
      ],
    );
  }
}