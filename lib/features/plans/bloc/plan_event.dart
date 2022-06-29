import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';

@immutable
abstract class PlanEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingPlansEvent extends PlanEvent {}

class GetAllPlansEvent extends PlanEvent {
  final bool refreshCache;

  GetAllPlansEvent({this.refreshCache = false});

  @override
  List<Object> get props => [refreshCache];
}

class GetPlanEvent extends PlanEvent {
  final String id;

  GetPlanEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddPlanEvent extends PlanEvent {
  final PlanModel plan;

  AddPlanEvent(this.plan);

  @override
  List<Object> get props => [plan];
}

class AddedPlanEvent extends PlanEvent {
  final PlanModel plan;

  AddedPlanEvent(this.plan);

  @override
  List<Object> get props => [plan];
}

class UpdatePlanEvent extends PlanEvent {
  final PlanModel plan;

  UpdatePlanEvent(this.plan);

  @override
  List<Object> get props => [plan];
}

class DeletePlanEvent extends PlanEvent {
  final String planId;

  DeletePlanEvent(this.planId);

  @override
  List<Object> get props => [planId];
}

class LoadedPlansEvent extends PlanEvent {
  final List<PlanModel> plans;

  LoadedPlansEvent(this.plans);

  @override
  List<Object> get props => [plans];
}

class LocalUpdatePlanEvent extends PlanEvent {
  final PlanModel plan;

  LocalUpdatePlanEvent(this.plan);

  @override
  List<Object> get props => [plan];
}
