import 'package:workout_watcher/features/plans/data/models/plan_exception_exercise.dart';

class PlanWeek {
  String? name;
  int? isoWdh;
  int? comWdh;
  int? isoSets;
  int? comSets;
  int? isoRpe;
  int? comRpe;

  List<PlanExceptionExerciseModel> exceptionalExercises = [];

  PlanWeek({
    required this.name,
    required this.isoWdh,
    required this.isoSets,
    required this.isoRpe,
    required this.comWdh,
    required this.comSets,
    required this.comRpe
  });

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "isoWdh": isoWdh,
      "isoSets": isoSets,
      "isoRpe": isoRpe,
      "comWdh": comWdh,
      "comSets": comSets,
      "comRpe": comRpe
    };
  }

  factory PlanWeek.fromMap(Map<String, dynamic> map) {
    return new PlanWeek(
        name: map["name"],
        isoWdh: map["isoWdh"],
        isoSets: map["isoSets"],
        isoRpe: map["isoRpe"],
        comWdh: map["comWdh"],
        comSets: map["comSets"],
        comRpe: map["comRpe"],
    );
  }
}