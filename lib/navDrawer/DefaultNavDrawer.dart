import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/MuscleGroupList.dart';
import 'package:workout_watcher/Views/ChartView.dart';
import 'package:workout_watcher/Views/DashboardView.dart';
import 'package:workout_watcher/Views/MeasureFormView.dart';
import 'package:workout_watcher/Views/SettingsView.dart';
import 'package:workout_watcher/ViewsList/MeasurementsListView.dart';
import 'package:workout_watcher/utils/Utils.dart';
import '../Views/WorkoutView.dart';

import '../Views/ExercisesList.dart';
import '../Plan/PlanList.dart';
import '../WorkoutCalendar.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: Colors.black87,
          child: ListView(
            children: <Widget>[
              Container(
                child: DrawerHeader(
                  child: Center(
                    child: Text(
                      'Workout-Tracker',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[Theme.of(context).colorScheme.primary, Colors.black])),
                ),
              ),
              ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                      "Dashboard",
                      style: TextStyle(
                          color: Colors.white
                      )
                  ),
                  onTap: () {
                    // close the drawer
                    Navigator.pop(context);

                    GoRouter.of(context).go("/dashboard");
                  }),
              ListTile(
                  leading: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  title: Text(
                      "Kalender",
                      style: TextStyle(
                          color: Colors.white
                      )
                  ),
                  onTap: () {
                    Utils.showToast("Kalender noch nicht verfügbar");

                    // close the drawer
//                    Navigator.pop(context);
//
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => WorkoutCalendar()
//                        )
//                    );
                  }),
              ListTile(
                leading: Icon(
                  Icons.auto_graph,
                  color: Colors.white,
                ),
                title: Text(
                  "Übersichten",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  // close the drawer
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChartView()
                      )
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.rule_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  "Messungen",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  // close the drawer
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MeasurementsListView()
                      )
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.task_alt,
                  color: Colors.white,
                ),
                title: Text(
                  "Ziele",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Utils.showToast("Ziele noch nicht verfügbar");
                },
              ),
              ListTile(
                  leading: Icon(
                    Icons.assignment,
                    color: Colors.white,
                  ),
                  title: Text(
                      "Plan",
                      style: TextStyle(
                          color: Colors.white
                      )
                  ),
                  onTap: () {
                    // close the drawer
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlanList()
                        )
                    );
                  }
                  ),
              ListTile(
                leading: Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                ),
                title: Text(
                  "Übungen",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExercisesView()
                      )
                  );
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  "Einstellungen",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);

                 GoRouter.of(context).go("/settings");
                },
              ),
            ],
          ),
        )
    );
  }
}
