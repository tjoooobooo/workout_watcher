import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Dialog/AddExceptionalExerciseDialog.dart';
import 'package:workout_watcher/Models/Plan.dart';
import 'package:workout_watcher/Models/PlanWeek.dart';
import 'package:workout_watcher/Plan/CreatePlanExceptionalExercises.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class CreatePlanWeekList extends StatelessWidget {
  final Plan plan;

  CreatePlanWeekList({required this.plan});

  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> isoWdhControllers = [];
  final List<TextEditingController> isoSetsControllers = [];
  final List<TextEditingController> isoRpeControllers = [];
  final List<TextEditingController> comWdhControllers = [];
  final List<TextEditingController> comSetsControllers = [];
  final List<TextEditingController> comRpeControllers = [];

  int? getValue(TextEditingController ctrl) {
    return ctrl.text.isEmpty ?
    null :
    int.parse(ctrl.text)
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Wochen bearbeiten"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              tooltip: "Speichern",
              onPressed: () async {
                for (var i = 0; i < this.plan.cycles; i++) {
                  this.plan.planWeeks[i] =
                  new PlanWeek(
                    name: nameControllers
                        .elementAt(i)
                        .text,
                    isoWdh: getValue(isoWdhControllers.elementAt(i)),
                    isoSets: getValue(isoSetsControllers.elementAt(i)),
                    isoRpe: getValue(isoRpeControllers.elementAt(i)),
                    comWdh: getValue(comWdhControllers.elementAt(i)),
                    comSets: getValue(comSetsControllers.elementAt(i)),
                    comRpe: getValue(comRpeControllers.elementAt(i)),
                  );
                }

                await FirebaseHandler.updatePlan(this.plan);
                Navigator.of(context).pop(this.plan);
              },
            )
          ],
        ),
        body: Container(
          color: Colors.black,
          child: ListView.builder(
              itemCount: plan.cycles,
              itemBuilder: (context, index) {
                nameControllers.add(new TextEditingController());
                isoWdhControllers.add(new TextEditingController());
                isoSetsControllers.add(new TextEditingController());
                isoRpeControllers.add(new TextEditingController());
                comWdhControllers.add(new TextEditingController());
                comSetsControllers.add(new TextEditingController());
                comRpeControllers.add(new TextEditingController());

                if (this.plan.planWeeks.containsKey(index)) {
                  PlanWeek? planWeek = this.plan.planWeeks[index];

                  nameControllers
                      .elementAt(index)
                      .text = planWeek!.name ?? "";
                  isoWdhControllers
                      .elementAt(index)
                      .text =
                  planWeek.isoWdh == null ? "" : planWeek.isoWdh.toString();
                  isoSetsControllers
                      .elementAt(index)
                      .text =
                  planWeek.isoSets == null ? "" : planWeek.isoSets.toString();
                  isoRpeControllers
                      .elementAt(index)
                      .text =
                  planWeek.isoRpe == null ? "" : planWeek.isoRpe.toString();
                  comWdhControllers
                      .elementAt(index)
                      .text =
                  planWeek.comWdh == null ? "" : planWeek.comWdh.toString();
                  comSetsControllers
                      .elementAt(index)
                      .text =
                  planWeek.comSets == null ? "" : planWeek.comSets.toString();
                  comRpeControllers
                      .elementAt(index)
                      .text =
                  planWeek.comRpe == null ? "" : planWeek.comRpe.toString();
                }

                return Card(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: Container(
                      padding: EdgeInsets.only(
                          top: 5,
                          bottom: 5
                      ),
                      child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child: WeekInputWidget(
                                    hint: "Woche $index",
                                    textInputType: TextInputType.text,
                                    controller: nameControllers[index],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            Container(
                                                child: Text(
                                                  "Isolations",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                )
                                            ),
                                            Container(
                                                child: Text(
                                                  "Coms",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                )
                                            ),
                                          ]
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.15,
                                            child: WeekInputWidget(
                                              hint: "wdh",
                                              textInputType: TextInputType.number,
                                              controller: isoWdhControllers[index],
                                            ),
                                          ),
                                          Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.15,
                                              child: WeekInputWidget(
                                                hint: "wdh",
                                                textInputType: TextInputType.number,
                                                controller: comWdhControllers[index],
                                              )
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.15,
                                            child: WeekInputWidget(
                                              hint: "sets",
                                              textInputType: TextInputType.number,
                                              controller: isoSetsControllers[index],
                                            ),
                                          ),
                                          Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.15,
                                              child: WeekInputWidget(
                                                hint: "sets",
                                                textInputType: TextInputType.number,
                                                controller: comSetsControllers[index],
                                              )
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.15,
                                            child: WeekInputWidget(
                                              hint: "rpe",
                                              textInputType: TextInputType.number,
                                              controller: isoRpeControllers[index],
                                            ),
                                          ),
                                          Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.15,
                                              child: WeekInputWidget(
                                                hint: "rpe",
                                                textInputType: TextInputType.number,
                                                controller: comRpeControllers[index],
                                              )
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CreatePlanExceptionalExercises(
                                        plan: this.plan)
                            )
                        ).then((exercise) {
                          if (exercise != null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddExceptionalExerciseDialog(exercise: exercise);
                              },
                            ).then((value) {

                            });
                          }
                        });
                      },
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.05,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.1,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))
                        ),
                        child: Icon(
                            Icons.edit_outlined,
                            color: Colors.black
                        ),
                      ),
                    ),
                    children: [
                      Container(
                        color: Colors.black54,
                        child: ListTile(
                          leading: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bankdrücken"
                                ),
                                Text(
                                    "detail"
                                ),
                              ],
                            ),
                          ),
                          title: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Wdh:"),
                                Text("5"),
                                Text("Sets:"),
                                Text("5"),
                                Text("RPE:"),
                                Text("8"),
                              ],
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                );
              }),
        )
    );
  }
}

class WeekInputWidget extends StatelessWidget {
  final String hint;
  final TextInputType textInputType;
  final TextEditingController controller;

  const WeekInputWidget({
    required this.hint,
    required this.textInputType,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: textInputType,
        cursorColor: Colors.black,
        style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.bold
            ),
            labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusColor: Colors.black,
        )
    );
  }
}