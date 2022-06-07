import 'package:workout_watcher/Models/PlanDay.dart';
import 'package:workout_watcher/Models/PlanWeek.dart';

enum PlanStates {
  EDITING,
  READY,
  ONGOING,
  EXECUTED
}

class Plan {
  String name;
  int cycles;
  String? id;

  // possible states editing/ready/ongoing/executed
  String state;

  List<PlanDay> planDays = [];
  Map<int, PlanWeek> planWeeks = new Map();

  Plan({
    required this.name,
    required this.state,
    required this.cycles
  });

  void addPlanDay(PlanDay planDay) {
    planDays.add(planDay);
  }

  Map<String, dynamic> toJSON() {
    List<Map<String, dynamic>> jsonPlanDays = [];
    List<Map<String, dynamic>> jsonPlanWeeks = [];

    planDays.forEach((planDay) {
      jsonPlanDays.add(planDay.toJSON());
    });

    planWeeks.forEach((int, planWeek) {
      jsonPlanWeeks.add(planWeek.toJSON());
    });

    Map<String, dynamic> out = {
      "name": name,
      "state": state,
      "cycles": cycles,
      "planDays": jsonPlanDays,
      "planWeeks": jsonPlanWeeks
    };

    if (id != null) {
      out["id"] = id;
    }

    return out;
  }

  factory Plan.fromMap(Map<String, dynamic> map, [String? id]) {
    Plan plan = new Plan(
      name: map["name"],
      state: map["state"],
      cycles: map["cycles"]
    );

    plan.id = id ?? map["id"];

    var rawPlanDays = map["planDays"];
    rawPlanDays.forEach((element) {
      plan.planDays.add(PlanDay.fromMap(element));
    });
    
    if (map.containsKey("planWeeks")) {
      var rawPlanWeeks = map["planWeeks"];
      int counter = 0;
      rawPlanWeeks.forEach((element) {
        plan.planWeeks[counter++] = PlanWeek.fromMap(element);
      });
    }

    return plan;
  }
}