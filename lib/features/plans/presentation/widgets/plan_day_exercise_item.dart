import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_state.dart';
import 'package:workout_watcher/features/plans/presentation/pages/plan_page_days.dart';

class PlanDayExerciseItem extends StatelessWidget {
  final String exerciseId;

  const PlanDayExerciseItem({
    Key? key,
    required this.exerciseId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String exerciseName = "";
    String detail = "";

    return Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        height: MediaQuery.of(context).size.height * 0.11,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Theme.of(context).primaryColorDark, width: 2.0)),
        child: BlocConsumer<ExercisesBloc, ExerciseState>(
          bloc: sl<ExercisesBloc>()..add(GetExerciseEvent(exerciseId)),
          listener: (context, state) {
            if (state.status.isLoadedExercise) {
              exerciseName = state.exercise!.name + ", " + state.exercise!.detail;
              detail = state.exercise!.getEquipmentLabel();
            }
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, right: 14.0),
                      child: const CircleAvatar(radius: 20.0, child: Icon(Icons.fitness_center)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          exerciseName,
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          detail,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(right: 8.0, left: 14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      ExerciseAdditionalInfoContainer(itemText: "3 Sätze"),
                      ExerciseAdditionalInfoContainer(itemText: "10 Wdh"),
                    ],
                  ),
                )
              ],
            );
          }
        ));
  }
}
