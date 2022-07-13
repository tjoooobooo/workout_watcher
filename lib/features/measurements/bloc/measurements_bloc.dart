import 'package:enum_to_string/enum_to_string.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_watcher/features/measurements/bloc/measurements_event.dart';
import 'package:workout_watcher/features/measurements/bloc/measurments_state.dart';
import 'package:workout_watcher/features/measurements/domain/repositories/measurment_repository.dart';

class MeasurementsBloc extends Bloc<MeasurementsEvent, MeasurementState> {
  final MeasurementRepository measurementRepository;

  MeasurementsBloc(this.measurementRepository)
      : super(const MeasurementState(status: MeasurementStateStatus.initial)) {
    on<GetAllMeasurementsEvent>((event, emit) async {
      emit(state.copyWith(status: MeasurementStateStatus.loading));
      final measurements =
          await measurementRepository.getAll(event.refreshCache);
      measurements.fold(
          (failure) => emit(state.copyWith(status: MeasurementStateStatus.error)),
          (success) => emit(state.copyWith(
              status: MeasurementStateStatus.loaded, measurements: success)));
    });

    on<GetMeasurementEvent>((event, emit) async {
      emit(state.copyWith(status: MeasurementStateStatus.loading));

      final exercise = await measurementRepository.getById(event.id);

      exercise.fold(
          (failure) => emit(state.copyWith(status: MeasurementStateStatus.error)),
          (success) => emit(state.copyWith(
              status: MeasurementStateStatus.loadedMeasurement, measurement: success)));
    });

    on<LoadingMeasurementsEvent>((event, emit) async {
      emit(state.copyWith(status: MeasurementStateStatus.loading));
    });

    on<LoadedMeasurementsEvent>((event, emit) async {
      emit(state.copyWith(
          status: MeasurementStateStatus.loaded, measurements: event.measurements));
    });

    on<AddMeasurementEvent>((event, emit) async {
      emit(state.copyWith(status: MeasurementStateStatus.loading));

      final addedExercise =
          await measurementRepository.add(event.measurement);

      addedExercise.fold(
          (failure) => emit(state.copyWith(status: MeasurementStateStatus.error)),
          (success) => add(GetAllMeasurementsEvent(refreshCache: true)));
    });

    on<UpdateMeasurementEvent>((event, emit) async {
      emit(state.copyWith(status: MeasurementStateStatus.loading));

      final addedExercise = await measurementRepository.update(event.measurement);

      addedExercise.fold(
              (failure) => emit(state.copyWith(status: MeasurementStateStatus.error)),
              (success) => add(GetAllMeasurementsEvent(refreshCache: true)));
    });

    on<DeleteMeasurementEvent>((event, emit) async {
      emit(state.copyWith(status: MeasurementStateStatus.loading));

      final addedExercise = await measurementRepository.delete(event.measurementId);

      addedExercise.fold(
              (failure) => emit(state.copyWith(status: MeasurementStateStatus.error)),
              (success) => add(GetAllMeasurementsEvent(refreshCache: true)));
    });

    on<UpdatingMeasurementEvent>((event, emit) async {
      emit(state.copyWith(status: MeasurementStateStatus.updating));
    });
  }
}
