import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';
import 'package:workout_watcher/features/plans/data/models/plan_exception_exercise.dart';
import 'package:workout_watcher/Models/Exercise.dart';
import 'package:workout_watcher/Widgets/CustomFormField.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/utils/Utils.dart';

class AddExceptionalExerciseDialog extends StatefulWidget {
  final ExerciseModel exercise;
  final int dayNr;
  final int weekNr;

  const AddExceptionalExerciseDialog(
      {Key? key, required this.exercise, required this.dayNr, required this.weekNr})
      : super(key: key);

  @override
  _AddExceptionalExerciseDialog createState() => _AddExceptionalExerciseDialog();
}

class _AddExceptionalExerciseDialog extends State<AddExceptionalExerciseDialog> {
  final formGlobalKey = GlobalKey<FormState>();
  final wdhCtrl = TextEditingController();
  final setCtrl = TextEditingController();
  final rpeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: AlertDialog(
      backgroundColor: Colors.black,
      title: Container(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          "Ausnahme für ${widget.exercise.name} hinzufügen",
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
      content: Container(
          color: Colors.black,
          child: Form(
            key: formGlobalKey,
            child: Column(
              children: [
                CustomTextFormField(
                  hint: "Wiederholungen",
                  errorMsg: "Bitte eingeben",
                  controller: wdhCtrl,
                  textInputType: const TextInputType.numberWithOptions(signed: false),
                ),
                CustomTextFormField(
                  hint: "Sätze",
                  errorMsg: "Bitte eingeben",
                  controller: setCtrl,
                  textInputType: const TextInputType.numberWithOptions(signed: false),
                ),
                CustomTextFormField(
                  hint: "RPE",
                  errorMsg: "Bitte eingeben",
                  controller: rpeCtrl,
                  textInputType: const TextInputType.numberWithOptions(signed: false),
                ),
              ],
            ),
          )),
      actions: [
        TextButton(
          child: const Text("Abbrechen"),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        TextButton(
            child: const Text("Hinzufügen"),
            onPressed: () async {
              if (formGlobalKey.currentState!.validate()) {
                PlanExceptionExerciseModel exceptionalExercise = PlanExceptionExerciseModel(
                    exerciseId: widget.exercise.id!,
                    dayNr: widget.dayNr,
                    wdh: Utils.getValue(wdhCtrl)!,
                    sets: Utils.getValue(setCtrl)!,
                    rpe: Utils.getValue(rpeCtrl)!);

                sl<PlanCreateBloc>().add(AddExceptionExerciseEvent(
                    weekNr: widget.weekNr, exercise: exceptionalExercise));

                GoRouter.of(context).pop();
              }
            })
      ],
    ));
  }
}
