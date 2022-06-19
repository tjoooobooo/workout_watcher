import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/features/exercises/presentation/pages/exercises_list_page.dart';

class ExerciseListItem extends StatefulWidget {
  ExerciseListItem({
    Key? key,
    required this.isSelectionMode,
    required this.exerciseIsSelected,
    required this.exercise,
  }) : super(key: key);

  bool exerciseIsSelected;
  final ExerciseModel exercise;
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
              selectedExerciseIds.add(widget.exercise.id!);
            } else {
              selectedExerciseIds.remove(widget.exercise.id);
            }

            setState(() {
              widget.exerciseIsSelected = !widget.exerciseIsSelected;
            });
          } else {
            GoRouter.of(context).push("/exercise/${widget.exercise.id}");
          }
        },
        child: Container(
            color: widget.exerciseIsSelected
                ? Theme.of(context).primaryColorLight
                : Theme.of(context).colorScheme.primary,
            child: ListTile(
              leading: widget.exercise.imageUrl != null
                  ? CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(widget.exercise.imageUrl!),
                      backgroundColor: Colors.transparent,
                    )
                  : const CircleAvatar(
                      radius: 20.0, child: Icon(Icons.fitness_center)),
              title: Text(widget.exercise.name),
              subtitle: Text(widget.exercise.detail),
              trailing:
                  Text(widget.exercise.type == "compound" ? "com" : "iso"),
            )));
  }
}
