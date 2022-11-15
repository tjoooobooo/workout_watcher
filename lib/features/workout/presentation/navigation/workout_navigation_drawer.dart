import 'package:flutter/material.dart';
import 'package:workout_watcher/features/workout/presentation/navigation/widgets/workout_navigation_exercise_item.dart';

class WorkoutNavigationDrawer extends StatelessWidget {
  const WorkoutNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).primaryColorDark,
            child: Column(children: <Widget>[
              DrawerHeader(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Einheit:",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            "Push",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Übungen:",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            "3/4",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Zeit:",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            "00:30:00h",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: SingleChildScrollView(
                    child: Column(
                  children: const [
                    WorkoutNavigationExerciseItem(
                        exerciseId: "2DGMIancYelqFjQqVKKo", isExecuted: true),
                    WorkoutNavigationExerciseItem(
                        exerciseId: "2DGMIancYelqFjQqVKKo", isExecuted: true),
                    WorkoutNavigationExerciseItem(
                        exerciseId: "2DGMIancYelqFjQqVKKo", isExecuted: true),
                    WorkoutNavigationExerciseItem(
                        exerciseId: "2DGMIancYelqFjQqVKKo", isExecuted: true),
                    WorkoutNavigationExerciseItem(exerciseId: "2DGMIancYelqFjQqVKKo"),
                    WorkoutNavigationExerciseItem(exerciseId: "2DGMIancYelqFjQqVKKo"),
                    WorkoutNavigationExerciseItem(exerciseId: "2DGMIancYelqFjQqVKKo"),
                    WorkoutNavigationExerciseItem(exerciseId: "2DGMIancYelqFjQqVKKo"),
                  ],
                )),
              ),
            ])));
  }
}
