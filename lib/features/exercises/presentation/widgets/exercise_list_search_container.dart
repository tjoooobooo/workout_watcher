import 'package:flutter/material.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';

class ExerciseListSearchContainer extends StatefulWidget {
  const ExerciseListSearchContainer({
    Key? key,
    required this.searchCtrl,
  }) : super(key: key);

  final TextEditingController searchCtrl;

  @override
  State<ExerciseListSearchContainer> createState() => _ExerciseListSearchContainerState();
}

class _ExerciseListSearchContainerState extends State<ExerciseListSearchContainer> {
  @override
  Widget build(BuildContext context) {
    // initial search for exercises on rebuild
    sl<ExercisesBloc>().add(SearchExercisesEvent(widget.searchCtrl.text));

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: TextFormField(
                controller: widget.searchCtrl,
                autofocus: false,
                onChanged: (value) {
                  sl<ExercisesBloc>().add(SearchExercisesEvent(value));

                  setState(() {});
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                decoration: InputDecoration(
                    hintText: "Suchen",
                    hintStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    suffixIcon: widget.searchCtrl.text != ""
                        ? GestureDetector(
                          onTap: () {
                            widget.searchCtrl.text = "";
                            sl<ExercisesBloc>().add(GetAllExercisesEvent());
                            setState(() {});
                          },
                          child: Icon(
                              Icons.cancel_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(6.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
