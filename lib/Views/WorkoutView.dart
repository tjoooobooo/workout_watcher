import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_watcher/Plan/CreatePlanMain.dart';
import 'package:workout_watcher/WorkoutCalendar.dart';
import '../core/features/navigation/default_navigation_drawer.dart';

import 'ExercisesList.dart';

class WorkoutView extends StatefulWidget {
  @override
  _WorkoutViewState createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  var currentSetNumber = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Push"),
        ),
        drawer: DefaultNavigationDrawer(),
        body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.fitness_center,
                            color: Colors.white,
                            size: 40.0,
                          )
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: const Text(
                          "Bankdrücken",
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    splashColor: Colors.blue,
                    iconSize: 300,
                    onPressed: () {
                      setState(() {
                        currentSetNumber++;
                      });
                    },
                  ),
                  Container(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: '10',
                                  hintStyle: TextStyle(
                                      color: Colors.blueGrey
                                  ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white
                                    )
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.cyanAccent
                                  )
                                )
                              ),
                              style: TextStyle(
                                color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Flexible(
                            child: Text(
                                " x ",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: '100',
                                  hintStyle: TextStyle(
                                    color: Colors.blueGrey
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.cyanAccent
                                      )
                                  )
                              ),
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "kg",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  createTable()
                ],
              ),
            )
        )
    );
  }

  Widget createTable() {
    List<TableRow> rows = [];

    rows.add(
        TableRow(
            children: const [
              Center(
                  child: Text(
                    "Satz",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  )
              ),
              Center(
                  child: Text(
                    "Wdh",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  )
              ),
              Center(
                  child: Text(
                    "Gewicht",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  )
              ),
            ],
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
            )

        )
    );

    for (int i = 1; i < 10; ++i) {
      rows.add(
          TableRow(
            decoration: BoxDecoration(
              color: currentSetNumber == i ?
                  Colors.greenAccent :
                  Theme.of(context).primaryColorLight
            ),
              children: [
                Center(child: Text(i.toString())),
                Center(child: Text((i + 1).toString())),
                Center(child: Text((i + 100).toString()))
              ]
          )
      );
    }

    return SingleChildScrollView(
        child: Container(
            color: Colors.cyan,
            margin: const EdgeInsets.all(15.0),
            child: Table(
              children: rows,
              border: TableBorder.all(
                  color: Colors.black,
                  width: 1.0,
                  style: BorderStyle.solid
              ),
            )
        ),
    );
  }
}
