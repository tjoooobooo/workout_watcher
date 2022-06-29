import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/Models/Plan.dart';
import 'package:workout_watcher/Plan/CreatePlanMain.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';

class PlanListItem extends StatelessWidget {
  const PlanListItem({
    Key? key,
    required this.plan,
  }) : super(key: key);

  final PlanModel plan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push("/plan/${plan.id}");
      },
      child: Card(
          color: Theme
              .of(context)
              .colorScheme
              .primary,
          child: ListTile(
              leading: const Icon(Icons.assignment),
              title: Text(plan.name),
              trailing: Text(plan.state.name)
          )
      ),
    );
  }
}