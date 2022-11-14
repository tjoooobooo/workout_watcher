import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/Dialog/AddExceptionalExerciseDialog.dart';
import 'package:workout_watcher/Models/Exercise.dart';
import 'package:workout_watcher/Models/Plan.dart';
import 'package:workout_watcher/Models/PlanDay.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_state.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';
import 'package:workout_watcher/features/plans/data/models/plan_day_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class PlanExceptionExerciseSelectionPage extends StatelessWidget {
  final int weekNr;

  const PlanExceptionExerciseSelectionPage({Key? key, required this.weekNr}) : super(key: key);

  ExerciseModel? getExercise(String exerciseId) {
    List<ExerciseModel> allExercises = sl<ExercisesBloc>().state.exercises!;

    for (var exercise in allExercises) {
      if (exerciseId == exercise.id) {
        return exercise;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Übungsausnahmen"),
        ),
        body: Container(
          color: Colors.black,
          child: BlocBuilder<ExercisesBloc, ExerciseState>(
              bloc: sl<ExercisesBloc>()..add(GetAllExercisesEvent()),
              builder: (context, state) {
                Map<ExerciseModel, String> planExercises = {};

                for (var planDay in sl<PlanCreateBloc>().state.plan!.planDays) {
                  for (var exerciseId in planDay.exercises) {
                    final exercise = getExercise(exerciseId);
                    planExercises[exercise!] = planDay.name;
                  }
                }

                return ListView.builder(
                    itemCount: planExercises.length,
                    itemBuilder: (context, index) {
                      ExerciseModel exercise = planExercises.keys.elementAt(index);
                      String dayName = planExercises.values.elementAt(index);

                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddExceptionalExerciseDialog(
                                  exercise: exercise, dayNr: index, weekNr: weekNr);
                            },
                          ).then((value) {
                            GoRouter.of(context).pop();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              alignment: Alignment.centerLeft,
                              child: Text(dayName),
                            ),
                            title: Text(
                                exercise.name +
                                    (exercise.detail.isNotEmpty ? "," + exercise.detail : ""),
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text(exercise.getEquipmentLabel(),
                                style: const TextStyle(color: Colors.white)),
                            trailing: Text(exercise.type == "compound" ? "com" : "iso",
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      );
                    });
              }),
        ));
  }
}
