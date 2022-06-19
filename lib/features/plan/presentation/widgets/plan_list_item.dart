import 'package:flutter/material.dart';
import 'package:workout_watcher/Models/Plan.dart';
import 'package:workout_watcher/Plan/CreatePlanMain.dart';

class PlanListItem extends StatelessWidget {
  const PlanListItem({
    Key? key,
    required this.currentPlan,
  }) : super(key: key);

  final Plan currentPlan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreatePlanMainPage(workoutPlan: currentPlan)
            )
        );
      },
      child: Card(
          color: Theme
              .of(context)
              .colorScheme
              .primary,
          child: ListTile(
              leading: const Icon(Icons.assignment),
              title: Text(currentPlan.name),
              trailing: Text(currentPlan.state)
          )
      ),
    );
  }
}