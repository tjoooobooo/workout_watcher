import 'package:flutter/material.dart';
import 'package:workout_watcher/features/plans/data/models/plan_day_model.dart';

class PlanDaySummaryContainer extends StatelessWidget {
  final PlanDayModel planDay;
  final int index;

  const PlanDaySummaryContainer({
    Key? key,
    required this.planDay,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int setCount = 0;

    return Padding(
      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.925,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Tag " + (index + 1).toString(),
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "${planDay.exercises.length} Übungen",
                style: const TextStyle(fontSize: 16),
              ),
              // Text(
              //   "$setCount Sätze",
              //   style: const TextStyle(fontSize: 16),
              // ),
            ],
          )),
    );
  }
}
