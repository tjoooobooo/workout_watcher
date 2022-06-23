import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_date_row.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_text_row.dart';
import 'package:workout_watcher/core/util/text_formfield_validator.dart';
import 'package:workout_watcher/features/measurements/presentation/widgets/measurement_page_header_container.dart';
import 'package:workout_watcher/features/measurements/bloc/measurements_bloc.dart';
import 'package:workout_watcher/features/measurements/bloc/measurements_event.dart';
import 'package:workout_watcher/features/measurements/bloc/measurments_state.dart';
import 'package:workout_watcher/features/measurements/data/models/measurement_model.dart';
import 'package:workout_watcher/features/measurements/presentation/widgets/measurement_page_sizes_container.dart';

class MeasurementPage extends StatefulWidget {
  final String measurementId;

  const MeasurementPage({Key? key, required this.measurementId})
      : super(key: key);

  @override
  State<MeasurementPage> createState() => _MeasurementPageState();
}

class _MeasurementPageState extends State<MeasurementPage> {
  final formGlobalKey = GlobalKey<FormState>();

  final dateCtrl = TextEditingController();
  final kfaCtrl = TextEditingController();
  final bodyWeightCtrl = TextEditingController();

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

  // return double value if field is filled if not return null
  double? getValue(TextEditingController ctrl) {
    if (ctrl.text.isEmpty) {
      return null;
    } else {
      String doubleVal = ctrl.text.replaceAll(",", ".").split(" ").elementAt(0);
      return double.parse(doubleVal);
    }
  }

  String getInitialMeasureValue(double? value) {
    return value == null
        ? ""
        : value.toString() + " cm";
  }

  void setValues(MeasurementModel measurement) {
    dateCtrl.text = DateFormat('dd.MM.yyy').format(measurement.date);
    bodyWeightCtrl.text = measurement.weight.toString() + " kg";
    kfaCtrl.text = measurement.kfa.toString() + " %";

    shouldersCtrl.text = getInitialMeasureValue(measurement.shoulders);
    chestCtrl.text = getInitialMeasureValue(measurement.chest);
    coreCtrl.text = getInitialMeasureValue(measurement.core);
    buttCtrl.text = getInitialMeasureValue(measurement.butt);
    rQuadCtrl.text = getInitialMeasureValue(measurement.rQuads);
    lQuadCtrl.text = getInitialMeasureValue(measurement.lQuads);
    rArmCtrl.text = getInitialMeasureValue(measurement.rArms);
    lArmCtrl.text = getInitialMeasureValue(measurement.lArms);
    rCalvesCtrl.text = getInitialMeasureValue(measurement.rCalves);
    lCalvesCtrl.text = getInitialMeasureValue(measurement.lCalves);
  }

  @override
  void initState() {
    super.initState();

    dateCtrl.text = DateFormat('dd.MM.yyy').format(DateTime.now());

    if (widget.measurementId != "0") {
      sl<MeasurementsBloc>().add(GetMeasurementEvent(widget.measurementId));
      sl<MeasurementsBloc>().add(UpdatingMeasurementEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Messung"),
          actions: [
            IconButton(
                onPressed: () {
                  if (formGlobalKey.currentState!.validate()) {
                    MeasurementModel measurement = MeasurementModel(
                      date: DateFormat('dd.MM.yyy').parse(dateCtrl.text),
                      weight: getValue(bodyWeightCtrl)!,
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
                    );

                    if (widget.measurementId != "0") {
                      sl<MeasurementsBloc>()
                          .add(UpdateMeasurementEvent(measurement));
                    } else {
                      sl<MeasurementsBloc>()
                          .add(AddMeasurementEvent(measurement));
                    }

                    GoRouter.of(context).pop();
                  }
                },
                icon: const Icon(Icons.save)),
            Visibility(
              visible: widget.measurementId != "0",
              child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Messung löschen"),
                            content: Text(
                                "Messung vom ${dateCtrl.text} wirklich löschen?"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red.shade400),
                                  child: Text("Löschen")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text("Abbrechen"))
                            ],
                          );
                        }).then((value) {
                      if (value) {
                        sl<MeasurementsBloc>().add(DeleteMeasurementEvent(widget.measurementId));
                        GoRouter.of(context).pop();
                      }
                    });
                  },
                  icon: const Icon(Icons.delete_forever)),
            ),
          ],
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).primaryColorDark,
            child: SingleChildScrollView(
                child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: BlocConsumer<MeasurementsBloc, MeasurementState>(
                      listener: (context, state) {
                        if (state.status ==
                            MeasurementStateStatus.loadedMeasurement) {
                          MeasurementModel measurement = state.measurement!;
                          setValues(measurement);
                        }
                      },
                      builder: (context, state) {
                        return Form(
                            key: formGlobalKey,
                            child: Column(children: [
                              MeasurementHeaderContainer(
                                  dateCtrl: dateCtrl,
                                  kfaCtrl: kfaCtrl,
                                  bodyWeightCtrl: bodyWeightCtrl),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.025),
                              MeasurementSizesContainer(
                                  shouldersCtrl: shouldersCtrl,
                                  chestCtrl: chestCtrl,
                                  coreCtrl: coreCtrl,
                                  buttCtrl: buttCtrl,
                                  lQuadCtrl: lQuadCtrl,
                                  rQuadCtrl: rQuadCtrl,
                                  lArmCtrl: lArmCtrl,
                                  rArmCtrl: rArmCtrl,
                                  lCalvesCtrl: lCalvesCtrl,
                                  rCalvesCtrl: rCalvesCtrl),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.025),
                            ]));
                      },
                    )),
              )
            ]))));
  }
}

