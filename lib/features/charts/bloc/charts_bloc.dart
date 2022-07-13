import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_watcher/features/charts/bloc/charts_event.dart';
import 'package:workout_watcher/features/charts/bloc/charts_state.dart';

class ChartsBloc extends Bloc<ChartsEvent, ChartState> {
  ChartsBloc() : super(const ChartState(status: ChartStateStatus.initial)) {
    on<InitialEvent>((event, emit) async {
      emit(state.copyWith(status: ChartStateStatus.initial, selectedData: ChartData.weight));
    });

    on<ChangedDataEvent>((event, emit) async {
      emit(state.copyWith(status: ChartStateStatus.changed, selectedData: event.selectedData));
    });
  }
}
