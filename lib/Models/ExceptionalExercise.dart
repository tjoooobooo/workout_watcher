import 'Exercise.dart';

class ExceptionalExercise {
  String exerciseId;
  int wdh;
  int sets;
  int rpe;

  ExceptionalExercise({
    required this.exerciseId,
    required this.wdh,
    required this.sets,
    required this.rpe
  });

  Map<String, dynamic> toJSON() {
    return {
      "exercise": exerciseId,
      "wdh": wdh,
      "sets": sets,
      "rpe": rpe
    };
  }

  factory ExceptionalExercise.fromMap(Map<String, dynamic> map) {
    return new ExceptionalExercise(
        exerciseId: map["exerciseId"],
        wdh: map["wdh"],
        sets: map["sets"],
        rpe: map["rpe"]
    );
  }
}