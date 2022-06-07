import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Models/ExceptionalExercise.dart';
import 'package:workout_watcher/Models/Exercise.dart';
import 'package:workout_watcher/Widgets/CustomFormField.dart';
import 'package:workout_watcher/utils/Utils.dart';

class AddExceptionalExerciseDialog extends StatefulWidget{
  Exercise exercise;
  AddExceptionalExerciseDialog({required this.exercise});

  @override
  _AddExceptionalExerciseDialog createState() =>
      new _AddExceptionalExerciseDialog(exercise: exercise);
}

class _AddExceptionalExerciseDialog extends State<AddExceptionalExerciseDialog> {
  Exercise exercise;
  _AddExceptionalExerciseDialog({required this.exercise});

  final formGlobalKey = GlobalKey < FormState > ();
  final wdhCtrl = new TextEditingController();
  final setCtrl = new TextEditingController();
  final rpeCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: Colors.black,
            title: Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Ausnahme für ${exercise.name} hinzufügen",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white
                ),
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
                        textInputType: TextInputType.numberWithOptions(
                          signed: false
                        ),
                      ),
                      CustomTextFormField(
                          hint: "Sätze",
                          errorMsg: "Bitte eingeben",
                          controller: setCtrl,
                        textInputType: TextInputType.numberWithOptions(
                            signed: false
                        ),
                      ),
                      CustomTextFormField(
                          hint: "RPE",
                          errorMsg: "Bitte eingeben",
                          controller: rpeCtrl,
                        textInputType: TextInputType.numberWithOptions(
                            signed: false
                        ),
                      ),
                    ],
                  ),
                )
            ),
          actions: [
            TextButton(
              child: Text("Abbrechen"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
                child: Text("Hinzufügen"),
                onPressed: () async {
                  if (formGlobalKey.currentState!.validate()) {
                    ExceptionalExercise exceptionalExercise = new ExceptionalExercise(
                        exerciseId: exercise.id!,
                        wdh: Utils.getValue(wdhCtrl)!,
                        sets: Utils.getValue(setCtrl)!,
                        rpe: Utils.getValue(rpeCtrl)!
                    );

                    Navigator.pop(context, exceptionalExercise);
                  }
                }
            )
          ],
        )
    );
  }
}