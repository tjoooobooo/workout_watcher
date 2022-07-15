import 'package:equatable/equatable.dart';

class PlanExceptionExerciseModel extends Equatable {
  final String exerciseId;
  final int dayNr;
  final int wdh;
  final int sets;
  final int rpe;

  const PlanExceptionExerciseModel({
    required this.exerciseId,
    required this.dayNr,
    required this.wdh,
    required this.sets,
    required this.rpe
  });


  Map<String, dynamic> toJSON() {
    return {
      "exerciseId": exerciseId,
      "dayNr": dayNr,
      "wdh": wdh,
      "sets": sets,
      "rpe": rpe
    };
  }

  factory PlanExceptionExerciseModel.fromJSON(Map<String, dynamic> json) {
    return PlanExceptionExerciseModel(
        exerciseId: json["exerciseId"],
        dayNr: json["dayNr"],
        wdh: json["wdh"],
        sets: json["sets"],
        rpe: json["rpe"]
    );
  }

  @override
  List<Object?> get props => [exerciseId, dayNr, wdh, sets, rpe];
}