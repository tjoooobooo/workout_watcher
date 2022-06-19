import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'WorkoutView.dart';
import 'package:workout_watcher/core/features/navigation/default_navigation_drawer.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardView createState() => _DashboardView();
}

class _DashboardView extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        drawer: DefaultNavigationDrawer(),
        body: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.black,
          child: Column(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: TextButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor
                      ),
                    ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkoutView()
                            )
                        );
                      },
                      label:  Text(
                        "Nächstes Training starten",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    icon: Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}