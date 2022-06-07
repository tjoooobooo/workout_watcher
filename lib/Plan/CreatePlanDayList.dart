import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Models/Exercise.dart';
import 'package:workout_watcher/Models/PlanDay.dart';
import 'package:workout_watcher/Views/ExercisesList.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class CreatePlanDayList extends StatefulWidget {
  PlanDay planDay;

  CreatePlanDayList({required this.planDay});

  @override
  State<CreatePlanDayList> createState() => _CreatePlanDayListState(planDay: planDay);
}

class _CreatePlanDayListState extends State<CreatePlanDayList> {
  PlanDay planDay;

  _CreatePlanDayListState({required this.planDay});

  void _onReorder(int oldIndex, int newIndex) {
    setState(
          () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final Exercise exercise = FirebaseHandler.getExerciseById(planDay.exercises.removeAt(oldIndex))!;
        planDay.exercises.insert(newIndex, exercise.id!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Übungen für ${widget.planDay.name}"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "Übung hinzufügen",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExercisesView(selectionMode: true)
                  )
              ).then((exercisesIDs) async {
                for (String exerciseId in exercisesIDs as List<String>) {
                  Exercise? exercise = await FirebaseHandler.getExerciseById(
                      exerciseId);

                  if (exercise != null) {
                    planDay.exercises.add(exercise.id!);
                  }
                }

                setState(() {});
              });
            },
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Center(
            child: ReorderableListView(
              onReorder: _onReorder,
              children: List.generate(planDay.exercises.length, (index) {
                final currentExerciseId = planDay.exercises.elementAt(index);
                final currentExercise = FirebaseHandler.getExerciseById(currentExerciseId);

                return Dismissible(
                    key: Key(currentExerciseId),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        planDay.exercises.remove(currentExerciseId);
                      });
                    },
                    background: Container(
                        color: Colors.red
                    ),
                    child: Card(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        child: ListTile(
                          leading: Icon(Icons.fitness_center),
                          title: Text(
                            currentExercise!.name,
                          ),
                          subtitle: Text(
                            currentExercise.detail,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.black,
                            ), onPressed: () {
                            setState(() {
                              planDay.exercises.remove(currentExerciseId);
                            });
                          },
                          ),
                        )
                    )
                );
              }),
            )
        ),
      ),
    );
  }
}