import 'package:dartz/dartz.dart';
import 'package:workout_watcher/core/error/failures.dart';
import 'package:workout_watcher/features/measurements/data/models/measurement_model.dart';
import 'package:workout_watcher/features/measurements/domain/repositories/measurment_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MeasurementRepositoryFirebase extends MeasurementRepository {
  List<MeasurementModel> cachedMeasurements = [];

  @override
  Future<Either<Failure, void>> add(MeasurementModel measurement) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Measurements")
        .add(measurement.toJSON());

    return right(null);
  }

  @override
  Future<Either<Failure, void>> delete(String measurementId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var rawMeasurements = await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Measurements")
        .doc(measurementId)
        .delete();

    return right(null);
  }

  @override
  Future<Either<Failure, List<MeasurementModel>>> getAll(
      bool refreshCache) async {
    if (cachedMeasurements.isEmpty || refreshCache) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      var rawMeasurements = await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection("Measurements")
          .get();

      List<MeasurementModel> measurements = [];

      for (var element in rawMeasurements.docs) {
        measurements.add(MeasurementModel.fromJSON(element.data(), element.id));
      }

      measurements.sort((a, b) => b.date.compareTo(a.date));
      return right(measurements);
    } else {
      return right(cachedMeasurements);
    }
  }

  @override
  Future<Either<Failure, MeasurementModel>> getById(String id) async {
    if (cachedMeasurements.isEmpty) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      var measurementData = await firestore
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection("Measurements")
          .doc(id)
          .get();
      MeasurementModel measurement =
          MeasurementModel.fromJSON(measurementData.data()!, id);
      return right(measurement);
    } else {
      for (var measurement in cachedMeasurements) {
        if (measurement.id == id) {
          return right(measurement);
        }
      }

      return left(NoExerciseFoundFailure());
    }
  }

  @override
  Future<Either<Failure, void>> update(MeasurementModel measurement) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Measurements")
        .doc(measurement.id)
        .set(measurement.toJSON());

    return right(null);
  }
}
