import 'Exercise.dart';

class PlanDay {
  String name;
  List<String> exercises = [];

  PlanDay({
    required this.name,
    List<String>? exercises
  }) : this.exercises = new List<String>.from(exercises ?? []);

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "exercises": exercises
    };
  }

  factory PlanDay.fromMap(Map<String, dynamic> map) {
    var ex = map["exercises"];

    return new PlanDay(
        name: map["name"],
        exercises: new List<String>.from(ex)
    );
  }
}