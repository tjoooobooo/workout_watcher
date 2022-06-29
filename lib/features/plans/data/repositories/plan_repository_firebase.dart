import 'package:dartz/dartz.dart';
import 'package:workout_watcher/core/error/failures.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';
import 'package:workout_watcher/features/plans/domain/repositories/plan_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlanRepositoryFirebase extends PlanRepository {
  @override
  Future<Either<Failure, List<PlanModel>>> getAll(bool refreshCache) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var rawPlans = await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Plan")
        .get()
    ;

    List<PlanModel> plans = [];

    for (var element in rawPlans.docs) {
      plans.add(PlanModel.fromMap(element.data(), element.id));
    }

    return right(plans);
  }

  @override
  Future<Either<Failure, PlanModel>> getById(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var rawPlan = await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Plan")
        .doc(id)
        .get()
    ;

    return right(PlanModel.fromMap(rawPlan.data()!, rawPlan.id));
  }

  @override
  Future<Either<Failure, PlanModel>> add(PlanModel plan) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var addedPlan = await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Plan")
        .add(plan.toJSON())
    ;

    var rawPlan = await addedPlan.get();

    return right(PlanModel.fromMap(rawPlan.data()!, rawPlan.id));
  }

  @override
  Future<Either<Failure, PlanModel>> update(PlanModel plan) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Plan")
        .doc(plan.id)
        .set(plan.toJSON())
    ;

    Either<Failure, PlanModel> eitherPlan = await getById(plan.id!);
    return eitherPlan.fold((l) => left(DBFailure()), (r) => right(r));
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection("Plan")
        .doc(id)
        .delete()
    ;

    return right(null);
  }
}
