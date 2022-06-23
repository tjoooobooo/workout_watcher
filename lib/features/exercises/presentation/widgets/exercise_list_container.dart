import 'package:flutter/material.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/features/exercises/presentation/pages/exercises_list_page.dart';
import 'package:workout_watcher/features/exercises/presentation/widgets/exercise_list_item.dart';

class ExerciseListContainer extends StatelessWidget {
  const ExerciseListContainer({
    Key? key,
    required this.exercises,
    required this.isSelectionMode,
  }) : super(key: key);

  final List<ExerciseModel> exercises;
  final bool isSelectionMode;

  // Group all exercises in muscle groups
  Map<String, List<ExerciseModel>> groupExercises(List<ExerciseModel> exercises) {
    Map<String, List<ExerciseModel>> exerciseInGroups = {
      "Brust": [],
      "Rücken": [],
      "Beine": [],
      "Schultern": [],
      "Bizeps": [],
      "Trizeps": []
    };

    for (var exercise in exercises) {
      if (exerciseInGroups.containsKey(exercise.muscleGroup) == false) {
        exerciseInGroups[exercise.muscleGroup] = [];
      }

      exerciseInGroups[exercise.muscleGroup]?.add(exercise);
    }

    exerciseInGroups.removeWhere((key, value) => value.isEmpty);
    return exerciseInGroups;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<ExerciseModel>> exerciseInGroups = groupExercises(exercises);

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: exerciseInGroups.length,
          itemBuilder: (context, index) {
            String muscleGroup = exerciseInGroups.keys
                .elementAt(
                index);
            List<
                ExerciseModel>? exercises = exerciseInGroups[muscleGroup];
            return Card(
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius. circular(15),
                ),
                child: ExpansionTile(
                  title: Text(
                    exerciseInGroups.keys.elementAt(index),
                    style: const TextStyle(
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
  }
}
