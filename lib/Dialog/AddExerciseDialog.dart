import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Models/Exercise.dart';
import 'package:workout_watcher/Widgets/CustomDropdownFormField.dart';
import 'package:workout_watcher/Widgets/CustomFormField.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

class AddExerciseDialog extends StatefulWidget{
  AddExerciseDialog();

  @override
  _AddExerciseDialog createState() =>
      _AddExerciseDialog();
}

class _AddExerciseDialog extends State<AddExerciseDialog> {
  _AddExerciseDialog({
    Key? key,
  });

  final formGlobalKey = GlobalKey < FormState > ();
  final nameCtrl = TextEditingController();
  final detailCtrl = TextEditingController();

  String? chosenExerciseType;
  String? chosenMuscleGroup;

  Map<String, String> exerciseTypes = {
    "isolation": "Isolationsübung",
    "compound": "Verbundübung"
  };

  Map<String, String> muscleGroups = {
    "Brust": "Brust",
    "Rücken": "Rücken",
    "Beine": "Beine",
    "Schultern": "Schultern",
    "Bizeps": "Bizeps",
    "Trizeps": "Trizeps",
    "Bauch": "Bauch",
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Colors.black,
          title: Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Übung hinzufügen",
              style: TextStyle(
                  fontSize: 25,
                color: Colors.white
              ),
            ),
          ),
          content: Container(
            color: Colors.black,
            child: Form(
              key: formGlobalKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFormField(hint: "Name", errorMsg: "Bitte Name eingeben", controller: nameCtrl),
                    CustomTextFormField(hint: "Übungsdetail", errorMsg: "Bitte Detail eingeben", controller: detailCtrl),
                    CustomDropdownFormField(
                      items: muscleGroups,
                      chosenExerciseType: chosenMuscleGroup,
                      hint: "Muskelgruppe wählen",
                      changeValueFunc: (chosen) {
                        chosenMuscleGroup = chosen;
                      },
                    ),
                    CustomDropdownFormField(
                        items: exerciseTypes,
                        chosenExerciseType: chosenExerciseType,
                        hint: "Übungsart wählen",
                      changeValueFunc: (chosenType) {
                          chosenExerciseType = chosenType;
                      },
                    )
                  ]
              ),
            ),
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
                if (formGlobalKey.currentState!.validate() && chosenExerciseType != null) {
                  Exercise exercise = Exercise(
                      name: nameCtrl.text,
                      detail: detailCtrl.text,
                      muscleGroup: chosenMuscleGroup!,
                      type: chosenExerciseType!
                  );

                  await FirebaseHandler.addExercise(exercise);
                  Navigator.pop(context);
                }
              }
          )
        ],
      ),
    );
  }
}