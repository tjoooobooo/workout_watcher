import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/Widgets/LoadWidget.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/features/navigation/default_navigation_drawer.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_state.dart';
import 'package:workout_watcher/features/exercises/presentation/widgets/exercise_list_container.dart';
import 'package:workout_watcher/features/exercises/presentation/widgets/exercise_list_search_container.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';

class ExercisesListPage extends StatefulWidget {
  final bool selectionMode;

  const ExercisesListPage({Key? key, this.selectionMode = false}) : super(key: key);

  @override
  _ExercisesListPage createState() => _ExercisesListPage();
}

List<String> selectedExerciseIds = [];

class _ExercisesListPage extends State<ExercisesListPage> {
  final TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    // clear selected exercises on first page open
    selectedExerciseIds.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Übungsübersicht"),
          actions: <Widget>[
            if (widget.selectionMode) IconButton(
              icon: const Icon(Icons.save),
              tooltip: "Übungen zum Plan hinzufügen",
              onPressed: () {
                sl<PlanCreateBloc>().add(AddExercisesToDayEvent(exerciseIds: selectedExerciseIds));
                GoRouter.of(context).pop();
              },
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              tooltip: "Übung hinzufügen",
              onPressed: () {
                GoRouter.of(context).push("/exercise/0");
              },
            )
          ],
        ),
        drawer: widget.selectionMode == false ? const DefaultNavigationDrawer() : null,
        body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColorDark,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                ExerciseListSearchContainer(searchCtrl: searchCtrl),
                Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: BlocConsumer<ExercisesBloc, ExerciseState>(
                      listener: (context, state) {
                        if (state.status == ExerciseStateStatus.loadedExercise) {
                          sl<ExercisesBloc>().add(GetAllExercisesEvent());
                        }
                      },
                        bloc: sl<ExercisesBloc>()..add(GetAllExercisesEvent()),
                        builder: ((context, state) {
                          if (state.status == ExerciseStateStatus.loading) {
                            return const LoadingWidget();
                          } else if (state.status == ExerciseStateStatus.loaded) {
                            return ExerciseListContainer(
                                exercises: state.exercises!,
                                isSelectionMode: widget.selectionMode
                            );
                          }

                          return Container();
                        })
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}

