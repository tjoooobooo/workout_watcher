import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:workout_watcher/Models/ExceptionalExercise.dart';

@immutable
class PlanWeekModel extends Equatable {
  final String name;
  final int? isoWdh;
  final int? comWdh;
  final int? isoSets;
  final int? comSets;
  final int? isoRpe;
  final int? comRpe;

  // List<ExceptionalExercise> exceptionalExercises = [];

  const PlanWeekModel({
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

  factory PlanWeekModel.fromMap(Map<String, dynamic> map) {
    return PlanWeekModel(
        name: map["name"],
        isoWdh: map["isoWdh"],
        isoSets: map["isoSets"],
        isoRpe: map["isoRpe"],
        comWdh: map["comWdh"],
        comSets: map["comSets"],
        comRpe: map["comRpe"],
    );
  }

  @override
  List<Object?> get props => [name, isoWdh, isoSets, comWdh, comSets, comRpe];
}