import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class MeasurementModel extends Equatable {
  DateTime date;
  double weight;
  double kfa;
  double? shoulders;
  double? chest;
  double? core;
  double? butt;
  double? rQuads;
  double? lQuads;
  double? rArms;
  double? lArms;
  double? rCalves;
  double? lCalves;

  String? id;

  MeasurementModel({
    required this.date,
    required this.weight,
    required this.kfa,
    this.shoulders,
    this.chest,
    this.core,
    this.butt,
    this.rQuads,
    this.lQuads,
    this.rArms,
    this.lArms,
    this.rCalves,
    this.lCalves,
  });

  Map<String, dynamic> toJSON() {
    return {
      "id": id ?? "",
      "date": date,
      "weight": weight,
      "kfa": kfa,
      "shoulders": shoulders,
      "chest": chest,
      "core": core,
      "butt": butt,
      "rQuads": rQuads,
      "lQuads": lQuads,
      "rArms": rArms,
      "lArms": lArms,
      "rCalves": rCalves,
      "lCalves": lCalves,
    };
  }

  factory MeasurementModel.fromJSON(Map<String, dynamic> map, String? id) {
    Timestamp timestamp = map["date"];

    MeasurementModel measurement = MeasurementModel(
      date: timestamp.toDate(),
      weight: map["weight"],
      kfa: map["kfa"],
      shoulders: map["shoulders"],
      chest: map["chest"],
      core: map["core"],
      butt: map["butt"],
      rQuads: map["rQuads"],
      lQuads: map["lQuads"],
      rArms: map["rArms"],
      lArms: map["lArms"],
      rCalves: map["rCalves"],
      lCalves: map["lCalves"],
    );

    measurement.id = id ?? map["id"];
    return measurement;
  }

  @override
  List<Object?> get props => [
        id,
        date,
        weight,
        kfa,
        shoulders,
        chest,
        core,
        butt,
        rQuads,
        lQuads,
        rArms,
        lArms,
        rCalves,
        lCalves
      ];
}
