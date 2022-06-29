import 'package:flutter/material.dart';
import 'package:workout_watcher/features/plans/presentation/pages/plan_page_days.dart';

class PlanDayExerciseItem extends StatelessWidget {
  const PlanDayExerciseItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        height: MediaQuery.of(context).size.height * 0.11,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Theme.of(context).primaryColorDark, width: 2.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8.0, right: 14.0),
                  child: const CircleAvatar(radius: 20.0, child: Icon(Icons.fitness_center)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Bankdrücken",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      "Langhantel",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 8.0, left: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  ExerciseAdditionalInfoContainer(itemText: "3 Sätze"),
                  ExerciseAdditionalInfoContainer(itemText: "10 Wdh"),
                ],
              ),
            )
          ],
        ));
  }
}
