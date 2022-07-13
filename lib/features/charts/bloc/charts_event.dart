import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/features/charts/bloc/charts_state.dart';

@immutable
abstract class ChartsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialEvent extends ChartsEvent {}

class ChangedDataEvent extends ChartsEvent {
  final ChartData selectedData;

  ChangedDataEvent({required this.selectedData});

  @override
  List<Object> get props => [selectedData];
}