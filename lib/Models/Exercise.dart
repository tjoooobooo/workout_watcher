class Exercise {
  String name;
  String detail;
  String muscleGroup;
  String type;

  String? id;

  Exercise({
    required this.name,
    required this.detail,
    required this.muscleGroup,
    required this.type
  });

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = new Map();

    map["name"] = name;
    map["detail"] = detail;
    map["muscleGroup"] = muscleGroup;
    map["type"] = type;

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  factory Exercise.fromMap(Map<String, dynamic> map, String? id) {
    Exercise exercise = Exercise(
        name: map["name"],
        detail: map["detail"],
        muscleGroup: map["muscleGroup"],
        type: map["type"]
    );
    exercise.id = id ?? map["id"];
    return exercise;
  }
}