import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';

enum PlanStateStatus { initial, loading, loaded, loadedPlan, error, updating, updated, added }

extension PlanStateStatusX on PlanStateStatus {
  bool get isInitial => this == PlanStateStatus.initial;

  bool get isLoading => this == PlanStateStatus.loading;

  bool get isLoaded => this == PlanStateStatus.loaded;

  bool get isLoadedPlan => this == PlanStateStatus.loadedPlan;

  bool get isError => this == PlanStateStatus.error;

  bool get isUpdating => this == PlanStateStatus.updating;

  bool get isUpdated => this == PlanStateStatus.updated;

  bool get isAdded => this == PlanStateStatus.added;
}

@immutable
class PlanState extends Equatable {
  final PlanStateStatus status;
  final List<PlanModel>? plans;
  final PlanModel? plan;

  const PlanState({this.status = PlanStateStatus.loading, this.plans, this.plan});

  @override
  List<Object?> get props => [status, plans, plan];

  PlanState copyWith({PlanStateStatus? status, List<PlanModel>? plans, PlanModel? plan}) {
    return PlanState(status: status ?? this.status, plans: plans ?? this.plans, plan: plan ?? this.plan);
  }
}
