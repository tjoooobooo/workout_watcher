import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class PlanDayModel extends Equatable {
  final String name;
  final List<String> exercises;

  PlanDayModel({
    required this.name,
    List<String>? exercises
  }) : exercises = List<String>.from(exercises ?? []);

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "exercises": exercises
    };
  }

  factory PlanDayModel.fromMap(Map<String, dynamic> map) {
    var ex = map["exercises"];

    return PlanDayModel(
        name: map["name"],
        exercises: List<String>.from(ex)
    );
  }

  @override
  List<Object?> get props => [name, exercises];
}