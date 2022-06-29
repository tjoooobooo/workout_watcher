import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';

enum PlanCreateStateStatus { initial, error, updated, switchedDay, switchDay, changedDayName, updating }

extension PlanCreateStateStatusX on PlanCreateStateStatus {
  bool get isInitial => this == PlanCreateStateStatus.initial;

  bool get isError => this == PlanCreateStateStatus.error;

  bool get isSwitchDay => this == PlanCreateStateStatus.switchDay;

  bool get hasSwitchedDay => this == PlanCreateStateStatus.switchedDay;

  bool get hasChangedDayName => this == PlanCreateStateStatus.changedDayName;

  bool get isUpdating => this == PlanCreateStateStatus.updating;
}

@immutable
class PlanCreateState extends Equatable {
  final PlanCreateStateStatus status;
  final PlanModel? plan;
  final int? dayIndex;

  const PlanCreateState({this.status = PlanCreateStateStatus.initial, this.plan, this.dayIndex});

  @override
  List<Object?> get props => [status, plan, dayIndex];

  PlanCreateState copyWith({PlanCreateStateStatus? status, PlanModel? plan, int? dayIndex}) {
    return PlanCreateState(
        status: status ?? this.status,
        plan: plan ?? this.plan,
        dayIndex: dayIndex ?? this.dayIndex);
  }
}
