import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_state.dart';

class DayRowItem extends StatelessWidget {
  final PlanCreateBloc planCreateBloc = sl<PlanCreateBloc>();
  final String name;
  final int dayNumber;

  DayRowItem({Key? key, required this.name, required this.dayNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanCreateBloc, PlanCreateState>(
      bloc: planCreateBloc,
      builder: (context, state) {
        bool isSelected = dayNumber == state.dayIndex;

        return GestureDetector(
          onTap: () {
            planCreateBloc.add(SwitchDayEvent(selectedDay: dayNumber));
          },
          child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15.0),
                border: isSelected
                    ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                )
                    : null,
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.15),
                    child: Center(
                        child: Text(
                          name,
                          style: TextStyle(
                              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ))),
              )),
        );
      }
    );
  }
}