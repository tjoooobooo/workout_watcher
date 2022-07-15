import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_state.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/core/presentation/widgets/icon_label_text_row.dart';

import '../../../../core/presentation/widgets/icon_label_dropdown_row.dart';

class ExercisePage extends StatefulWidget {
  final String exerciseId;

  const ExercisePage({Key? key, required this.exerciseId}) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final formGlobalKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final detailCtrl = TextEditingController();

  String? exerciseId;
  String? chosenExerciseType;
  String? chosenMuscleGroup;
  String? chosenEquipment;
  String? exerciseImageUrl;
  XFile? chosenImage;

  Map<String, String> equipmentTypes = {
    "lh": "Langhantel",
    "kh": "Kurzhantel",
    "cable": "Kabelzug",
    "cable_tower": "Kabelturm",
    "machine": "Maschine",
    "pl": "Plate loaded",
    "multi": "Multipresse",
    "sz": "SZ-Stange",
    "body_weight": "Körpergewicht",
  };

  Map<String, String> exerciseTypes = {
    "isolation": "Isolation",
    "compound": "Verbund"
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
  void initState() {
    super.initState();

    if (widget.exerciseId != "0") {
      sl<ExercisesBloc>().add(GetExerciseEvent(widget.exerciseId));
      sl<ExercisesBloc>().add(UpdatingExerciseEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: BlocBuilder<ExercisesBloc, ExerciseState>(
            buildWhen: (previous, current) {
              if (current.status == ExerciseStateStatus.loadedExercise) {
                return true;
              }

              return false;
            },
            builder: (context, state) {
              if (state.status == ExerciseStateStatus.loadedExercise) {
                return Text(state.exercise!.name);
              }

              return const Text("Übung erstellen");
            },
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  if (formGlobalKey.currentState!.validate() &&
                      chosenExerciseType != null) {
                    if (exerciseId != "0") {
                      ExerciseModel exercise = ExerciseModel(
                          id: exerciseId,
                          name: nameCtrl.text,
                          detail: detailCtrl.text,
                          muscleGroup: chosenMuscleGroup!,
                          equipment: chosenEquipment!,
                          type: chosenExerciseType!,
                          imageUrl: exerciseImageUrl,
                          image: chosenImage);

                      sl<ExercisesBloc>().add(UpdateExerciseEvent(exercise));
                    } else {
                      ExerciseModel exercise = ExerciseModel(
                          name: nameCtrl.text,
                          detail: detailCtrl.text,
                          muscleGroup: chosenMuscleGroup!,
                          equipment: chosenEquipment!,
                          type: chosenExerciseType!,
                          image: chosenImage);

                      sl<ExercisesBloc>().add(AddExerciseEvent(exercise));
                    }

                    GoRouter.of(context).pop();
                  }
                },
                icon: const Icon(Icons.save)),
            Visibility(
              visible: widget.exerciseId != "0",
              child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Übung löschen"),
                            content: Text(
                                "Sind wirklich sicher, dass sie die Übung \"${nameCtrl.text}\" löschen wollen?"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red.shade400),
                                  child: Text("Löschen")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text("Abbrechen"))
                            ],
                          );
                        }).then((value) {
                      if (value) {
                        sl<ExercisesBloc>()
                            .add(DeleteExerciseEvent(exerciseId!));
                        GoRouter.of(context).pop();
                      }
                    });
                  },
                  icon: const Icon(Icons.delete_forever)),
            ),
          ]),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).primaryColorDark,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Center(
                  child: BlocConsumer<ExercisesBloc, ExerciseState>(
                      listener: ((context, state) {
                if (state.status == ExerciseStateStatus.loadedExercise && state.exercise?.id == widget.exerciseId) {
                  ExerciseModel exercise = state.exercise!;

                  exerciseId = exercise.id;
                  nameCtrl.text = exercise.name;
                  detailCtrl.text = exercise.detail;
                  chosenMuscleGroup = exercise.muscleGroup;
                  chosenEquipment = exercise.equipment;
                  chosenExerciseType = exercise.type;
                  exerciseImageUrl = exercise.imageUrl;
                }
              }), builder: (context, state) {
                if (state.status == ExerciseStateStatus.loading) {
                  return const LoadingWidget();
                } else {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Form(
                      key: formGlobalKey,
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.025),
                                    const Text(
                                      "Anzeigebild",
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.white),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    GestureDetector(
                                        onTap: () async {
                                          chosenImage = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);

                                          setState(() {});
                                        },
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.225,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Center(
                                                child: chosenImage != null
                                                    ? CircleAvatar(
                                                        radius: 90.0,
                                                        backgroundImage:
                                                            FileImage(File(
                                                                chosenImage!
                                                                    .path)))
                                                    : exerciseImageUrl != null
                                                        ? CircleAvatar(
                                                            radius: 90.0,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    exerciseImageUrl!))
                                                        : CircleAvatar(
                                                            radius: 90.0,
                                                            child: Icon(
                                                              Icons
                                                                  .image_search_rounded,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                            ),
                                                          ))))
                                  ],
                                ),
                              ),
                              IconLabelTextRow(
                                controller: nameCtrl,
                                iconData: Icons.abc_rounded,
                                label: "Name",
                              ),
                              IconLabelTextRow(
                                iconData: Icons.info_outline_rounded,
                                label: "Details",
                                controller: detailCtrl,
                                validateForValue: false,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              IconLabelDropdownRow(
                                  label: "Muskelgruppe",
                                  iconData: Icons.fitness_center,
                                  items: muscleGroups,
                                  initialType: chosenMuscleGroup,
                                  changeValueFunc: (chosen) {
                                    chosenMuscleGroup = chosen;
                                  }),
                              IconLabelDropdownRow(
                                  label: "Equipment",
                                  iconData: Icons.fitness_center,
                                  items: equipmentTypes,
                                  initialType: chosenEquipment,
                                  changeValueFunc: (chosen) {
                                    chosenEquipment = chosen;
                                  }),
                              IconLabelDropdownRow(
                                  label: "Art",
                                  iconData: Icons.type_specimen,
                                  items: exerciseTypes,
                                  initialType: chosenExerciseType,
                                  changeValueFunc: (chosen) {
                                    chosenExerciseType = chosen;
                                  }),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  );
                }
              })),
            ],
          ),
        ),
      ),
    );
  }
}
