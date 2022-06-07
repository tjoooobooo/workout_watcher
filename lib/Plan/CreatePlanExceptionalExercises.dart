import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Models/Exercise.dart';
import 'package:workout_watcher/Models/Plan.dart';
import 'package:workout_watcher/Models/PlanDay.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class CreatePlanExceptionalExercises extends StatelessWidget {
  Plan plan;

  CreatePlanExceptionalExercises({required this.plan});

  @override
  Widget build(BuildContext context) {
    Map<Exercise, String> allExercises = new Map();

    this.plan.planDays.forEach((PlanDay planDay) {
      planDay.exercises.forEach((exerciseId) {
        final exercise = FirebaseHandler.getExerciseById(exerciseId);
        allExercises[exercise!] = planDay.name;
      });
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("Übungsausnahmen"),
        ),
        body: Container(
          color: Colors.black,
          child: ListView.builder(
              itemCount: allExercises.length,
              itemBuilder: (context, index) {
                Exercise exercise = allExercises.keys.elementAt(index);
                String dayName = allExercises.values.elementAt(index);

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(exercise);
                  },
                  child: Container(
                      child: Card(
                        color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                        child: ListTile(
                          leading: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            alignment: Alignment.centerLeft,
                            child: Text(
                                dayName
                            ),
                          ),
                          title: Text(exercise.name),
                          subtitle: Text(exercise.detail),
                          trailing: Text(
                              exercise.type == "compound" ?
                              "com" :
                              "iso"
                          ),
                        ),
                      )
                  ),
                );
              }
          ),
        )
    );
  }
}
