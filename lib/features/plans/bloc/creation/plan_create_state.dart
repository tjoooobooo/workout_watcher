import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';

enum PlanCreateStateStatus {
  initial,
  editing,
  error,
  updated,
  switchedDay,
  switchDay,
  changedDayName,
  updating
}

extension PlanCreateStateStatusX on PlanCreateStateStatus {
  bool get isInitial => this == PlanCreateStateStatus.initial;

  bool get isError => this == PlanCreateStateStatus.error;

  bool get isSwitchDay => this == PlanCreateStateStatus.switchDay;

  bool get hasSwitchedDay => this == PlanCreateStateStatus.switchedDay;

  bool get hasChangedDayName => this == PlanCreateStateStatus.changedDayName;

  bool get isUpdating => this == PlanCreateStateStatus.updating;

  bool get hasUpdated => this == PlanCreateStateStatus.updated;

  bool get isEditing => this == PlanCreateStateStatus.editing;
}

@immutable
class PlanCreateState extends Equatable {
  final PlanCreateStateStatus status;
  final PlanModel? plan;
  final int? dayIndex;
  final bool? isCurrentlySwitchingDay;

  const PlanCreateState(
      {this.status = PlanCreateStateStatus.initial,
      this.plan,
      this.dayIndex,
      this.isCurrentlySwitchingDay});

  @override
  List<Object?> get props => [status, plan, dayIndex, isCurrentlySwitchingDay];

  PlanCreateState copyWith(
      {PlanCreateStateStatus? status,
      PlanModel? plan,
      int? dayIndex,
      bool? isCurrentlySwitchingDay}) {
    return PlanCreateState(
        status: status ?? this.status,
        plan: plan ?? this.plan,
        dayIndex: dayIndex ?? this.dayIndex,
        isCurrentlySwitchingDay: isCurrentlySwitchingDay ?? this.isCurrentlySwitchingDay);
  }
}
