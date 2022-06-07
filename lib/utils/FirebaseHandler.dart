import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_watcher/Models/Exercise.dart';
import 'package:workout_watcher/Models/Measurement.dart';
import 'package:workout_watcher/Models/Plan.dart';

class FirebaseHandler {

  static Map<String, Exercise> cachedExercises = new Map();

  static Future<Map<String, Exercise>> getAllExercises({bool updateCache = false}) async {
    if (FirebaseHandler.cachedExercises.isEmpty || updateCache) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      Map<String, Exercise> exercises = Map();

      var exerciseCollection = await firestore
          .collection("exercises")
          .get()
      ;

      for (var exerciseDoc in exerciseCollection.docs) {
        Exercise exercise = Exercise.fromMap(
            exerciseDoc.data(), exerciseDoc.id);

        if (exercises.containsKey(exercise.id) == false) {
          exercises[exercise.id!] = exercise;
        }
      }

      FirebaseHandler.cachedExercises = exercises;
      return exercises;
    } else {
      return FirebaseHandler.cachedExercises;
    }
  }

  static Exercise? getExerciseById(String id) {
    if (FirebaseHandler.cachedExercises.containsKey(id)) {
      return FirebaseHandler.cachedExercises[id];
    }

    return null;
  }

  static Future<Map<String, List<Exercise>>> getAllExercisesInGroups() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, List<Exercise>> exercises = {
      "Brust": [],
      "Rücken": [],
      "Beine": [],
      "Schultern": [],
      "Bizeps": [],
      "Trizeps": []
    };

    var exerciseCollection = await firestore
        .collection("exercises")
        .get()
    ;

    for (var exerciseDoc in exerciseCollection.docs) {
      Exercise exercise = Exercise.fromMap(
          exerciseDoc.data(), exerciseDoc.id);

      if (exercises.containsKey(exercise.muscleGroup) == false) {
        exercises[exercise.muscleGroup] = [];
      }

      exercises[exercise.muscleGroup]!.add(exercise);
    }

    return exercises;
  }

  static Future addExercise(Exercise exercise) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference documentReference = await firestore
      .collection("exercises")
      .add(exercise.toJSON())
    ;
  }

  static Future<void> addPlan(Plan plan) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    if (plan.id != null) {
      await FirebaseHandler.updatePlan(plan);
    } else {
      await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection("Plan")
          .add(plan.toJSON())
      ;
    }
  }

  static Future<void> updatePlan(Plan plan) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Plan")
        .doc(plan.id)
        .set(plan.toJSON())
    ;
  }

  static Future<List<Plan>> getPlans() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var rawPlans = await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Plan")
        .get()
    ;

    List<Plan> plans = [];

    rawPlans.docs.forEach((element) {
      plans.add(Plan.fromMap(element.data(), element.id));
    });

    return plans;
  }


  static Future<void> addMeasurement(Measurement measurement) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Measurements")
        .add(measurement.toJSON())
    ;
  }

  static Future<List<Measurement>> getMeasurements() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var rawMeasurements = await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Measurements")
        .get()
    ;

    List<Measurement> measurements = [];

    rawMeasurements.docs.forEach((element) {
      measurements.add(Measurement.fromMap(element.data(), element.id));
    });

    measurements.sort((a, b) => b.date.compareTo(a.date));
    return measurements;
  }

  static Future<void> deleteMeasurement(Measurement measurement) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var rawMeasurements = await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Measurements")
        .doc(measurement.id)
        .delete()
    ;
  }

  static Future<bool> hasActivePlan() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var rawMeasurements = await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
    ;

    return false;
  }

}