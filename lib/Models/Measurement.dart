import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Measurement {
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

  Measurement({
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

  factory Measurement.fromMap(Map<String, dynamic> map, String? id) {
    Timestamp timestamp = map["date"];

    Measurement measurement = new Measurement(
      date: timestamp.toDate(),
      weight: map["weight"],
      kfa: map["kfa"] ?? null,
      shoulders: map["shoulders"] ?? null,
      chest: map["chest"] ?? null,
      core: map["core"] ?? null,
      butt: map["butt"],

      rQuads: map["rQuads"] ?? null,
      lQuads: map["lQuads"] ?? null,

      rArms: map["rArms"] ?? null,
      lArms: map["lArms"] ?? null,

      rCalves: map["rCalves"] ?? null,
      lCalves: map["lCalves"] ?? null,
    );

    measurement.id = id ?? map["id"];
    return measurement;
  }
}