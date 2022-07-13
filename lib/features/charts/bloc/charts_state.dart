import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ChartStateStatus { initial, changed }

enum ChartData { weight, kfa, shoulders, chest, core, lArms, rArms, butt, lQuads, rQuads, lCalves, rCalves }

extension ChartStateStatusX on ChartStateStatus {
  bool get isInitial => this == ChartStateStatus.initial;
  bool get hasChanged => this == ChartStateStatus.changed;
}

@immutable
class ChartState extends Equatable {
  final ChartStateStatus status;
  final ChartData selectedData;

  const ChartState({this.status = ChartStateStatus.initial, this.selectedData = ChartData.weight});

  @override
  List<Object?> get props => [status, selectedData];

  ChartState copyWith({ChartStateStatus? status, ChartData? selectedData}) {
    return ChartState(
        status: status ?? this.status, selectedData: selectedData ?? this.selectedData);
  }
}
