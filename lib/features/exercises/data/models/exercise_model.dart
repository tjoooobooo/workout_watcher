import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

enum EquipmentTypes {
  lh,
  kh,
  cable,
  cableTower,
  machine,
  pl,
  multi,
  sz,
  bodyWeight
}

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

  String getEquipmentLabel() {
    switch (equipment) {
      case ("lh"):
        return "Langhantel";
      case ("kh"):
        return "Kurzhantel";
      case ("cable"):
        return "Kabelzug";
      case ("cable_tower"):
        return "Kabelturm";
      case ("machine"):
        return "Maschine";
      case ("pl"):
        return "Plate loaded";
      case ("multi"):
        return "Multipresse";
      case ("sz"):
        return "SZ-Stange";
      case ("body_weight"):
        return "Körpergewicht";
    }

    return "";
  }

  // String getEquipmentLabel() {
  //   switch (equipment) {
  //     case EquipmentTypes.lh:
  //       return "Langhantel";
  //     case EquipmentTypes.kh:
  //       return "Kurzhantel";
  //     case EquipmentTypes.cable:
  //       return "Kabelzug";
  //     case EquipmentTypes.cableTower:
  //       return "Kabelturm";
  //     case EquipmentTypes.machine:
  //       return "Maschine";
  //     case EquipmentTypes.pl:
  //       return "Plate loaded";
  //     case EquipmentTypes.multi:
  //       return "Multipresse";
  //     case EquipmentTypes.sz:
  //       return "SZ-Stange";
  //     case EquipmentTypes.bodyWeight:
  //       return "Körpergewicht";
  //     case null:
  //       return "";
  //   }
  // }

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
