import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Models/Plan.dart';
import 'package:workout_watcher/Models/PlanDay.dart';
import 'package:workout_watcher/Plan/CreatePlanWeekList.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';
import '../Views/ExercisesList.dart';
import 'package:workout_watcher/Plan/CreatePlanDayList.dart';
import '../navDrawer/DefaultNavDrawer.dart';

class CreatePlanMainPage extends StatefulWidget {
  Plan? workoutPlan;

  CreatePlanMainPage({this.workoutPlan});

  @override
  _CreatePlanMainState createState() => _CreatePlanMainState(workoutPlan: workoutPlan);
}

class _CreatePlanMainState extends State<CreatePlanMainPage> {
  Plan? workoutPlan;

  _CreatePlanMainState({this.workoutPlan});

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController cycleCtrl = TextEditingController();
  final TextEditingController dayCtrl = TextEditingController();

  void _onReorder(int oldIndex, int newIndex) {
    setState(
          () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final PlanDay item = workoutPlan!.planDays.removeAt(oldIndex);
        workoutPlan!.planDays.insert(newIndex, item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (workoutPlan == null) {
      workoutPlan = new Plan(
          name: "Plan I",
          state: "editing",
          cycles: 5
      );
    }

    nameCtrl.text = workoutPlan!.name;
    cycleCtrl.text = workoutPlan!.cycles.toString();

    return Scaffold(
        appBar: AppBar(
          title: Text("Plan erstellen"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              tooltip: "Plan speichern",
              onPressed: () async {
                await FirebaseHandler.addPlan(workoutPlan!);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        drawer: NavDrawer(),
        body: Container(
          color: Colors.black,
          child: Form(
            child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0
                ),
                child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      TextFormField(
                        onChanged: (newValue) {
                          workoutPlan!.name = newValue;
                        },
                        controller: nameCtrl,
                        autofocus: false,
                        style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2.0,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2.0,
                                )
                            ),
                            labelText: "Plan Name",
                          labelStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 60,
                              child: TextFormField(
                                controller: cycleCtrl,
                                onChanged: (newValue) {
                                  workoutPlan!.cycles = int.parse(newValue);
                                },
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 2.0,
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 2.0,
                                      )
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Wochen",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                )
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreatePlanWeekList(plan: this.workoutPlan!)
                                        )
                                    ).then((updatedPlan) {
                                      if (updatedPlan is Plan) {
                                        this.workoutPlan = updatedPlan;
                                      }
                                  });
                                  },
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.black,
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0
                        ),
                        color: Theme.of(context).colorScheme.primary,
                        child: Text(
                            "Trainingstage wählen",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          )
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        controller: dayCtrl,
                        autofocus: false,
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2.0,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2.0,
                                )
                            ),
                            labelText: "Einheit hinzufügen",
                            labelStyle: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white
                            ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                workoutPlan!.addPlanDay(new PlanDay(name: dayCtrl.text));
                                dayCtrl.clear();
                              });
                            },
                          ),
                        ),
                        onFieldSubmitted: (text) {
                          setState(() {
                            workoutPlan!.addPlanDay(new PlanDay(name: dayCtrl.text));
                            dayCtrl.clear();
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      workoutPlan!.planDays.length == 0 ?
                      Center(
                        child: Text(
                          "Noch keine Tage hinzugefügt",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary
                          )
                        )
                      )     :
                      Expanded(
                        child: ReorderableListView(
                            onReorder: _onReorder,
                            children: List.generate( workoutPlan!.planDays.length, (index) {
                              final PlanDay planDay =  workoutPlan!.planDays[index];
                              return Dismissible(
                                  key: Key(planDay.name),
                                  onDismissed: (direction) {
                                    setState(() {
                                      workoutPlan!.planDays.removeAt(index);
                                    });
                                  },
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                      color: Colors.red
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      color: Theme.of(context).colorScheme.primary,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreatePlanDayList(planDay: planDay)
                                              )
                                          );
                                        },
                                        subtitle: Text('Tag ${index + 1}'),
                                        title: Text(
                                          planDay.name,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.delete_forever,
                                            color: Colors.black,
                                          ),
                                          onPressed: () async {
                                            String dialog = await showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Einheit löschen"
                                                    ),
                                                    content: Text(
                                                        "Bist du sicher, dass du die Einheit \'$planDay\' löschen willst?"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text(
                                                            "Bestätigen"),
                                                        onPressed: () {
                                                          setState(() {
                                                            Navigator.of(
                                                                context)
                                                                .pop("confirm");
                                                          });
                                                        },
                                                      ),
                                                      FlatButton(
                                                        child: Text(
                                                            "Abbrechen"),
                                                        onPressed: () {
                                                          Navigator.of(
                                                              context)
                                                              .pop("cancel");
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                }
                                            );

                                            // check if confirm delete button clicked
                                            if (dialog == "confirm") {
                                              setState(() {
                                                workoutPlan!.planDays
                                                    .removeAt(
                                                    index);
                                                Scaffold
                                                    .of(context)
                                                    .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Day \' $planDay\' dismissed')
                                                    )
                                                );
                                              });
                                            }
                                          },
                                        ),
                                      )
                                  )
                              );
                            })
                        )
                        ,
                      )
                    ]
                )
            ),
          ),
        )
    );
  }
}