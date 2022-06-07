import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final exercises =  [
      "Bankdrücken", "Fliegende", "Brustpresse"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises for <>"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                    leading: Icon(Icons.fitness_center),
                    title: Text(exercises[index]),
                  )
              );
            }
        ),
      ),
    );
  }
}