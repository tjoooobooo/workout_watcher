import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workout_watcher/core/error/failures.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/features/exercises/domain/repositorys/exercise_repository.dart';

class ExerciseRepositoryFirebase extends ExerciseRepository {
  List<ExerciseModel> cachedExercises = [];

  @override
  Future<Either<Failure, void>> addExercise(ExerciseModel exercise) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, dynamic> exerciseJson = exercise.toJSON();

    if (exercise.image != null) {
      final String imageUrl = await uploadImage(exercise.image!);
      exerciseJson["imageUrl"] = imageUrl;
    }

    DocumentReference documentReference =
        await firestore.collection("exercises").add(exerciseJson);

    return right(null);
  }

  @override
  Future<Either<Failure, void>> updateExercise(ExerciseModel exercise) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, dynamic> exerciseJson = exercise.toJSON();

    // upload the image if not already uploaded
    if (exercise.image != null) {
      final String imageUrl = await uploadImage(exercise.image!);
      exerciseJson["imageUrl"] = imageUrl;
    }

    // delete old image if existent
    if (exercise.imageUrl != null) {
      await FirebaseStorage.instance.refFromURL(exercise.imageUrl!).delete();
    }

    await firestore.collection("exercises").doc(exercise.id).set(exerciseJson);

    return right(null);
  }

  @override
  Future<Either<Failure, void>> deleteExercise(String exerciseId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("exercises").doc(exerciseId).delete();
    return right(null);
  }

  Future<String> uploadImage(XFile image) async {
    final path = "exercise_images/${image.name}";
    final file = File(image.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() => {});

    return await snapshot.ref.getDownloadURL();
  }

  @override
  Future<Either<Failure, List<ExerciseModel>>> getAllExercises(bool refreshCache) async {
    if (cachedExercises.isEmpty || refreshCache) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      List<ExerciseModel> exercises = [];

      var exerciseCollection = await firestore.collection("exercises").get();

      for (var exerciseDoc in exerciseCollection.docs) {
        exercises
            .add(ExerciseModel.fromJson(exerciseDoc.data(), exerciseDoc.id));
      }

      return right(cachedExercises = exercises);
    } else {
      return right(cachedExercises);
    }
  }

  @override
  Future<Either<Failure, ExerciseModel>> getExercise(String id) async {
    if (cachedExercises.isEmpty) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      var exerciseData = await firestore.collection("exercises").doc(id).get();
      ExerciseModel exercise = ExerciseModel.fromJson(exerciseData.data()!, id);
      return right(exercise);
    } else {

      for (var exercise in cachedExercises) {
        if (exercise.id == id) {
          return right(exercise);
        }
      }

      return left(NoExerciseFoundFailure());
    }
  }

  @override
  Future<Either<Failure, List<ExerciseModel>>> searchExercises(
      String term) async {
    if (cachedExercises.isEmpty) {
      getAllExercises(false);
    }

    List<ExerciseModel> exercises = [];

    String searchTerm = term.toLowerCase();

    for (var exercise in cachedExercises) {
      if (exercise.name.toLowerCase().contains(searchTerm) ||
          exercise.detail.toLowerCase().contains(searchTerm)) {
        exercises.add(exercise);
      }
    }

    return right(exercises);
  }
}
