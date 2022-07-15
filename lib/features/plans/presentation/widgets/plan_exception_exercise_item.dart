import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_state.dart';
import 'package:workout_watcher/features/plans/data/models/plan_exception_exercise.dart';

class PlanExceptionExerciseItem extends StatelessWidget {
  const PlanExceptionExerciseItem({
    Key? key,
    required this.element,
  }) : super(key: key);

  final PlanExceptionExerciseModel element;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExercisesBloc, ExerciseState>(
        bloc: sl<ExercisesBloc>()..add(GetExerciseEvent(element.exerciseId)),
        builder: (context, state) {
          if (state.status.isLoadedExercise && state.exercise!.id == element.exerciseId) {
            return Container(
                color: Colors.white54,
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.exercise!.name),
                            Text(state.exercise!.detail),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 7,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Wdh:"),
                            Text(element.wdh.toString()),
                            const Text("Sets:"),
                            Text(element.sets.toString()),
                            const Text("RPE:"),
                            Text(element.rpe.toString()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          } else {
            return const LoadingWidget();
          }
        }
    );
  }
}