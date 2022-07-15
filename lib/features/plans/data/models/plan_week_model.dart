import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:workout_watcher/features/plans/data/models/plan_exception_exercise.dart';

@immutable
class PlanWeekModel extends Equatable {
  final String name;
  final int? isoWdh;
  final int? comWdh;
  final int? isoSets;
  final int? comSets;
  final int? isoRpe;
  final int? comRpe;
  final List<PlanExceptionExerciseModel> exceptionalExercises;

  const PlanWeekModel(
      {required this.name,
      required this.isoWdh,
      required this.isoSets,
      required this.isoRpe,
      required this.comWdh,
      required this.comSets,
      required this.comRpe,
      this.exceptionalExercises = const []});

  PlanWeekModel copyWith({String? name, int? isoWdh, int? comWdh, int? isoSets, int? comSets,
      int? isoRpe, int? comRpe, List<PlanExceptionExerciseModel>? exceptionalExercises}) {
    return PlanWeekModel(
        name: name ?? this.name,
        isoWdh: isoWdh ?? this.isoWdh,
        isoSets: isoSets ?? this.isoSets,
        isoRpe: isoRpe ?? this.isoRpe,
        comWdh: comWdh ?? this.comWdh,
        comSets: comSets ?? this.comSets,
        comRpe: comRpe ?? this.comRpe,
        exceptionalExercises: exceptionalExercises ?? this.exceptionalExercises);
  }

  PlanWeekModel addExceptionExercise(PlanExceptionExerciseModel exceptionExercise) {
    List<PlanExceptionExerciseModel> newExceptionExercises = exceptionalExercises;
    newExceptionExercises.add(exceptionExercise);

    return PlanWeekModel(
        name: name,
        isoWdh: isoWdh,
        isoSets: isoSets,
        isoRpe: isoRpe,
        comWdh: comWdh,
        comSets: comSets,
        comRpe: comRpe,
        exceptionalExercises: newExceptionExercises);
  }

  Map<String, dynamic> toJSON() {
    List<Map<String, dynamic>> jsonExceptionExercises = [];

    for (var exceptionExercise in exceptionalExercises) {
      jsonExceptionExercises.add(exceptionExercise.toJSON());
    }

    return {
      "name": name,
      "isoWdh": isoWdh,
      "isoSets": isoSets,
      "isoRpe": isoRpe,
      "comWdh": comWdh,
      "comSets": comSets,
      "comRpe": comRpe,
      "exceptionExercises": jsonExceptionExercises
    };
  }

  factory PlanWeekModel.fromJSON(Map<String, dynamic> map) {
    List<PlanExceptionExerciseModel> newExceptionExercises = [];

    if (map.containsKey("exceptionExercises")) {
      var rawExceptionExercises = map["exceptionExercises"];
      rawExceptionExercises.forEach((exceptionExercise) {
        newExceptionExercises.add(PlanExceptionExerciseModel.fromJSON(exceptionExercise));
      });
    }

    return PlanWeekModel(
        name: map["name"],
        isoWdh: map["isoWdh"],
        isoSets: map["isoSets"],
        isoRpe: map["isoRpe"],
        comWdh: map["comWdh"],
        comSets: map["comSets"],
        comRpe: map["comRpe"],
        exceptionalExercises: newExceptionExercises);
  }

  @override
  List<Object?> get props => [name, isoWdh, isoSets, comWdh, comSets, comRpe, exceptionalExercises];
}
