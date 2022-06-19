import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

@immutable
class ExerciseModel extends Equatable {
  final String name;
  final String detail;
  final String muscleGroup;
  final String type;
  final String? equipment;
  final XFile? image;
  final String? imageUrl;

  final String? id;

  const ExerciseModel(
      {this.id,
      required this.name,
      required this.detail,
      required this.muscleGroup,
      required this.type,
      this.equipment,
      this.image,
      this.imageUrl});

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = {};

    map["name"] = name;
    map["detail"] = detail;
    map["muscleGroup"] = muscleGroup;
    map["equipment"] = equipment;
    map["type"] = type;

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  factory ExerciseModel.fromJson(Map<String, dynamic> map, String? id) {
    ExerciseModel exercise = ExerciseModel(
        id: id ?? map["id"],
        name: map["name"],
        detail: map["detail"],
        muscleGroup: map["muscleGroup"],
        equipment: map["equipment"],
        type: map["type"],
        imageUrl: map["imageUrl"]);
    return exercise;
  }

  @override
  List<Object?> get props =>
      [id, name, detail, muscleGroup, equipment, type, image];
}
