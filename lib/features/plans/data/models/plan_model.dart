import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:workout_watcher/Models/PlanDay.dart';
import 'package:workout_watcher/features/plans/bloc/plan_state.dart';
import 'package:workout_watcher/features/plans/data/models/plan_day_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_week_model.dart';

enum PlanModelStates { editing, ready, ongoing, executed }

class PlanModel extends Equatable {
  final String name;
  final int units;
  final int cycles;
  final String? id;

  // possible states editing/ready/ongoing/executed
  final PlanModelStates state;

  final List<PlanDayModel> planDays;
  final Map<int, PlanWeekModel> planWeeks;

  const PlanModel(
      {required this.name,
      required this.cycles,
      required this.units,
      this.id,
      this.state = PlanModelStates.editing,
      this.planDays = const [],
      this.planWeeks = const {}});

  PlanModel copyWith(
      {String? name,
      int? cycles,
      int? units,
      PlanModelStates? state,
      List<PlanDayModel>? planDays,
      Map<int, PlanWeekModel>? planWeeks}) {
    return PlanModel(
        id: id,
        name: name ?? this.name,
        cycles: cycles ?? this.cycles,
        units: units ?? this.units,
        state: state ?? this.state,
        planDays: planDays ?? this.planDays,
        planWeeks: planWeeks ?? this.planWeeks);
  }

  PlanModel replaceDay(int index, PlanDayModel planDay) {
    List<PlanDayModel> currentDays = planDays;
    currentDays[index] = planDay;
    return copyWith(planDays: currentDays);
  }

  void addPlanDay(PlanDayModel planDay) {
    planDays.add(planDay);
  }

  Map<String, dynamic> toJSON() {
    List<Map<String, dynamic>> jsonPlanDays = [];
    List<Map<String, dynamic>> jsonPlanWeeks = [];

    // create empty plan days if not existent
    if (planDays.isEmpty) {
      for (int i = 0; i < units; i++) {
        jsonPlanDays.add(PlanDayModel(name: "Tag ${i + 1}").toJSON());
      }
    } else {
      for (var planDay in planDays) {
        jsonPlanDays.add(planDay.toJSON());
      }
    }

    planWeeks.forEach((nr, planWeek) {
      jsonPlanWeeks.add(planWeek.toJSON());
    });

    Map<String, dynamic> out = {
      "name": name,
      "state": state.name,
      "cycles": cycles,
      "units": units,
      "planDays": jsonPlanDays,
      "planWeeks": jsonPlanWeeks
    };

    if (id != null) {
      out["id"] = id;
    }

    return out;
  }

  factory PlanModel.fromMap(Map<String, dynamic> map, [String? id]) {
    List<PlanDayModel> newPlanDays = [];
    Map<int, PlanWeekModel> newPlanWeeks = {};

    var rawPlanDays = map["planDays"] ?? [];
    rawPlanDays.forEach((element) {
      newPlanDays.add(PlanDayModel.fromMap(element));
    });

    if (map.containsKey("planWeeks")) {
      var rawPlanWeeks = map["planWeeks"];
      int counter = 0;
      rawPlanWeeks.forEach((element) {
        newPlanWeeks[counter++] = PlanWeekModel.fromMap(element);
      });
    }

    return PlanModel(
        id: id ?? map["id"],
        name: map["name"],
        state: EnumToString.fromString(PlanModelStates.values, map["state"])!,
        cycles: map["cycles"],
        units: map["units"],
        planDays: newPlanDays,
        planWeeks: newPlanWeeks);
  }

  @override
  List<Object?> get props => [id, name, cycles];
}
