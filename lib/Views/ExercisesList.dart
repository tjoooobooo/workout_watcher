import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Dialog/AddExerciseDialog.dart';
import 'package:workout_watcher/Models/Exercise.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class ExercisesView extends StatefulWidget {
  bool selectionMode = false;

  ExercisesView({this.selectionMode = false});

  _ExercisesView createState() => _ExercisesView(selectionMode);
}

List<String> selectedExerciseIds = [];

class _ExercisesView extends State<ExercisesView> {
  bool isSelectionMode = false;
  Map<String, List<Exercise>> exerciseInGroups = new HashMap();

  _ExercisesView(this.isSelectionMode);

  getExercises() async {
    this.exerciseInGroups = await FirebaseHandler.getAllExercisesInGroups();
  }

  @override
  Widget build(BuildContext context) {
    selectedExerciseIds.clear();

    return Scaffold(
        appBar: AppBar(
          title: Text("Übungsübersicht"),
          actions: <Widget>[
            if (isSelectionMode) IconButton(
              icon: Icon(Icons.save),
              tooltip: "Übungen zum Plan hinzufügen",
              onPressed: () {
                Navigator.pop(context, selectedExerciseIds);
              },
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              tooltip: "Übung hinzufügen",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddExerciseDialog();
                  },
                ).then((value) {
                  FirebaseHandler.getAllExercises(updateCache: true);
                  setState(() {});
                });
              },
            )
    ],
    ),
    body: Container(
            color: Colors.black,
            child: FutureBuilder(
                future: getExercises(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Center(
                      child: ListView.builder(
                          itemCount: exerciseInGroups.length,
                          itemBuilder: (context, index) {
                            String muscleGroup = exerciseInGroups.keys
                                .elementAt(
                                index);
                            List<
                                Exercise>? exercises = exerciseInGroups[muscleGroup];
                            return Card(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                                child: ExpansionTile(
                                  title: Text(
                                    exerciseInGroups.keys.elementAt(index),
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  children: exercises!.map((exercise) {
                                    var indexExercise = exercises.indexOf(
                                        exercise);

                                    bool exerciseIsSelected = isSelectionMode &&
                                        selectedExerciseIds.contains(
                                            exercise.id)
                                    ;

                                    return ExerciseListItem(
                                      exerciseIsSelected: exerciseIsSelected,
                                      exercise: exercise,
                                      isSelectionMode: isSelectionMode,
                                    );
                                  }).toList(),
                                )
                            );
                          }
                      ),
                    );
                  } else {
                    return LoadingWidget();
                  }
                })
        )
    );
  }
}

class ExerciseListItem extends StatefulWidget {
  ExerciseListItem({
    Key? key,
    required this.isSelectionMode,
    required this.exerciseIsSelected,
    required this.exercise,
  }) : super(key: key);

  bool exerciseIsSelected;
  final Exercise exercise;
  final bool isSelectionMode;

  @override
  State<ExerciseListItem> createState() => _ExerciseListItemState();
}

class _ExerciseListItemState extends State<ExerciseListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.isSelectionMode) {
            if (selectedExerciseIds.contains(widget.exercise.id) == false) {
              selectedExerciseIds.add(
                  widget.exercise.id!);
            } else {
              selectedExerciseIds.remove(widget.exercise.id);
            }

            setState(() {
              widget.exerciseIsSelected = !widget.exerciseIsSelected;
            });
          }
        },
        child: Container(
            color: widget.exerciseIsSelected ?
            Theme
                .of(context)
                .primaryColorLight :
            Theme
                .of(context)
                .colorScheme
                .primary,
            child: ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text(widget.exercise.name),
              subtitle: Text(widget.exercise.detail),
              trailing: Text(
                  widget.exercise.type == "compound" ?
                  "com" :
                "iso"
              ),
            )
        )
    );
  }
}
