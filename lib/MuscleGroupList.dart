import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Views/ExercisesList.dart';

class MuscleGroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final muscleGroupTitles = [
      'Bauch', 'Beine', 'Brust',
      'Rücken', 'Schultern', 'Bizeps', 'Trizeps'
    ];

    final muscleGroupIcons = [

    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Muscle group overview"),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: muscleGroupTitles.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                      leading: Icon(Icons.fitness_center),
                      title: Text(muscleGroupTitles[index]),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExercisesView()
                            )
                        );
                      },
                    )
                );
              })
      ),
    );
  }
}