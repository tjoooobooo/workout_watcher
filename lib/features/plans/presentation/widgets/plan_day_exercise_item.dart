import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_state.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';
import 'package:workout_watcher/features/plans/presentation/pages/plan_days_page.dart';

class PlanDayExerciseItem extends StatelessWidget {
  final String exerciseId;
  final bool showDelete;

  const PlanDayExerciseItem({Key? key, required this.exerciseId, this.showDelete = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String exerciseName = "";
    String detail = "";
    String? imageUrl;

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push("/exercise/$exerciseId");
      },
      child: Container(
          margin: const EdgeInsets.all(4.0),
          height: MediaQuery.of(context).size.height * 0.11,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Theme.of(context).primaryColorDark, width: 2.0)),
          child: BlocConsumer<ExercisesBloc, ExerciseState>(
              bloc: sl<ExercisesBloc>()..add(GetExerciseEvent(exerciseId)),
              listener: (context, state) {
                if (state.status.isLoadedExercise && state.exercise!.id == exerciseId) {
                  exerciseName = state.exercise!.name + ", " + state.exercise!.detail;
                  detail = state.exercise!.getEquipmentLabel();
                  imageUrl = state.exercise!.imageUrl;
                }
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                          child: imageUrl != null
                              ? CircleAvatar(
                                  radius: 28.0,
                                  backgroundImage: NetworkImage(imageUrl!),
                                  backgroundColor: Colors.transparent,
                                )
                              : const CircleAvatar(radius: 28.0, child: Icon(Icons.fitness_center)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exerciseName,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                detail,
                                textAlign: TextAlign.left,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    showDelete ?
                    Container(
                      padding: const EdgeInsets.only(right: 8.0, left: 14.0),
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        IconButton(
                            onPressed: () {
                              sl<PlanCreateBloc>()
                                  .add(DeleteExerciseFromDayEvent(exerciseId: exerciseId));
                            },
                            icon: Icon(
                              FontAwesomeIcons.trash,
                              color: Colors.red.shade400,
                            ))
                      ]),
                    ) : Container()
                  ],
                );
              })),
    );
  }
}
