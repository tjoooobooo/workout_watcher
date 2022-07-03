import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_watcher/Models/Plan.dart';
import 'package:workout_watcher/Plan/CreatePlanMain.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';

class PlanListItem extends StatelessWidget {
  final PlanModel plan;

  const PlanListItem({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    int exercises = 0;
    int sets = 0;

    switch (plan.state) {
      case PlanModelStates.editing:
        iconData = FontAwesomeIcons.pen;
        break;
      case PlanModelStates.ready:
        iconData = FontAwesomeIcons.check;
        break;
      case PlanModelStates.ongoing:
        iconData = FontAwesomeIcons.clock;
        break;
      case PlanModelStates.executed:
        iconData = FontAwesomeIcons.checkDouble;
        break;
    }

    for (var planDay in plan.planDays) {
      exercises += planDay.exercises.length;
    }

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push("/plan/${plan.id}");
      },
      child: Card(
          color: Theme.of(context).colorScheme.primary,
          child: ListTile(
              leading: CircleAvatar(radius: 25, child: Icon(iconData)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Zyklen " + plan.cycles.toString()),
                          Text("Einheiten " + plan.units.toString()),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.075),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Übungen " + exercises.toString()),
                          Text("Sätze " + sets.toString())
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Text(plan.state.name))),
    );
  }
}
