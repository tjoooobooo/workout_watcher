import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/features/measurements/data/models/measurement_model.dart';

@immutable
abstract class MeasurementsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingMeasurementsEvent extends MeasurementsEvent {}

class GetAllMeasurementsEvent extends MeasurementsEvent {
  final bool refreshCache;

  GetAllMeasurementsEvent({this.refreshCache = false});

  @override
  List<Object> get props => [refreshCache];
}

class GetMeasurementEvent extends MeasurementsEvent {
  final String id;

  GetMeasurementEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SearchMeasurementsEvent extends MeasurementsEvent {
  final String search;

  SearchMeasurementsEvent(this.search);

  @override
  List<Object> get props => [search];
}

class AddMeasurementEvent extends MeasurementsEvent {
  final MeasurementModel measurement;

  AddMeasurementEvent(this.measurement);

  @override
  List<Object> get props => [measurement];
}

class UpdateMeasurementEvent extends MeasurementsEvent {
  final MeasurementModel measurement;

  UpdateMeasurementEvent(this.measurement);

  @override
  List<Object> get props => [measurement];
}

class UpdatingMeasurementEvent extends MeasurementsEvent {}

class DeleteMeasurementEvent extends MeasurementsEvent {
  final String measurementId;

  DeleteMeasurementEvent(this.measurementId);

  @override
  List<Object> get props => [measurementId];
}

class LoadedMeasurementsEvent extends MeasurementsEvent {
  final List<MeasurementModel> measurements;

  LoadedMeasurementsEvent(this.measurements);

  @override
  List<Object> get props => [measurements];
}