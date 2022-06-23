import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/features/measurements/data/models/measurement_model.dart';

enum MeasurementStateStatus {
  initial,
  loading,
  loaded,
  loadedMeasurement,
  error,
  updating
}

extension MeasurementStateStatusX on MeasurementStateStatus {
  bool get isInitial => this == MeasurementStateStatus.initial;

  bool get isLoading => this == MeasurementStateStatus.loading;

  bool get isLoaded => this == MeasurementStateStatus.loaded;

  bool get isLoadedMeasurement =>
      this == MeasurementStateStatus.loadedMeasurement;

  bool get isError => this == MeasurementStateStatus.error;

  bool get isUpdating => this == MeasurementStateStatus.updating;
}

@immutable
class MeasurementState extends Equatable {
  final MeasurementStateStatus status;
  final List<MeasurementModel> measurements;
  final MeasurementModel? measurement;

  const MeasurementState(
      {this.status = MeasurementStateStatus.loading,
      this.measurements = const [],
      this.measurement});

  @override
  List<Object> get props {
    if (measurement == null) {
      return [status, measurements];
    } else {
      return [status, measurements, measurement!];
    }
  }

  MeasurementState copyWith(
      {MeasurementStateStatus? status,
      List<MeasurementModel>? measurements,
      MeasurementModel? measurement}) {
    return MeasurementState(
        status: status ?? this.status,
        measurements: measurements ?? [],
        measurement: measurement);
  }
}
