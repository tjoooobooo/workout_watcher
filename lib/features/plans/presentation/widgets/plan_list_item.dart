import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
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
        child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.975,
            margin: const EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Theme.of(context).primaryColorDark, width: 2.0),
            ),
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: CircleAvatar(radius: 25, child: Icon(iconData))
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Zyklen " + plan.cycles.toString(),
                                    style: const TextStyle(fontSize: 16, color: Colors.white)),
                                Text("Einheiten " + plan.units.toString(),
                                    style: const TextStyle(fontSize: 16, color: Colors.white)),
                              ],
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.075),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Übungen " + exercises.toString(),
                                    style: const TextStyle(fontSize: 16, color: Colors.white)),
                                Text("Sätze " + sets.toString(),
                                    style: const TextStyle(fontSize: 16, color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Text(plan.state.name, style: const TextStyle(
                  fontSize: 18
                ))
              ],
            )));
  }
}
