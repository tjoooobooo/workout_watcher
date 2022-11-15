import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workout_watcher/Views/ExercisesList.dart';
import 'package:workout_watcher/core/presentation/widgets/section_header_container.dart';
import 'package:workout_watcher/features/plans/presentation/widgets/plan_day_exercise_item.dart';
import 'package:workout_watcher/features/workout/presentation/navigation/workout_navigation_drawer.dart';
import '../../../../core/features/navigation/default_navigation_drawer.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  var currentSetNumber = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Push"),
        ),
        drawer: const WorkoutNavigationDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(12.0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    const PlanDayExerciseItem(exerciseId: "2DGMIancYelqFjQqVKKo", showDelete: false),
                    ClipOval(
                      child: Material(
                        color: Theme.of(context).primaryColorDark.withOpacity(0.4),
                        child: InkWell(
                          splashColor: Colors.green.withOpacity(0.8),
                          onTap: () {
                            setState(() {
                              currentSetNumber++;
                            });
                          },
                          child: FaIcon(
                              FontAwesomeIcons.circleCheck,
                            size: MediaQuery.of(context).size.height * 0.2,
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
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
                    )
                  ],
                ),
              ),
              createTable(),
              const SectionHeaderContainer(header: "Letztes Training"),
              createTable()
            ],
          ),
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
                    "#",
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
              Center(
                  child: Text(
                    "RPE",
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

    for (int i = 1; i < 5; ++i) {
      rows.add(
          TableRow(
            decoration: BoxDecoration(
              color: currentSetNumber == i ?
                  Colors.greenAccent.withOpacity(0.4) :
                  null
            ),
              children: [
                Center(child: Text(i.toString())),
                Center(child: Text((i + 1).toString())),
                Center(child: Text((i + 100).toString())),
                Center(child: Text((i + 100).toString())),
              ]
          )
      );
    }

    return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Table(
                children: rows,
                border: TableBorder.all(
                    color: Colors.black,
                    width: 1.2,
                    borderRadius: BorderRadius.circular(15),
                    style: BorderStyle.solid
                ),
              ),
            )
        ),
    );
  }
}
