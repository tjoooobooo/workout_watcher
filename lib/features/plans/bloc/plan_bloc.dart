import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/plan_event.dart';
import 'package:workout_watcher/features/plans/bloc/plan_state.dart';
import 'package:workout_watcher/features/plans/domain/repositories/plan_repository.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final PlanRepository planRepository;

  PlanBloc(this.planRepository)
      : super(const PlanState(status: PlanStateStatus.initial)) {
    on<GetAllPlansEvent>((event, emit) async {
      final exercises =
      await planRepository.getAll(event.refreshCache);
      exercises.fold(
              (failure) => emit(state.copyWith(status: PlanStateStatus.error)),
              (success) => emit(state.copyWith(
              status: PlanStateStatus.loaded, plans: success)));
    });

    on<GetPlanEvent>((event, emit) async {
      emit(state.copyWith(status: PlanStateStatus.loading));

      final plan = await planRepository.getById(event.id);

      plan.fold(
              (failure) => emit(state.copyWith(status: PlanStateStatus.error)),
              (success) => emit(state.copyWith(
              status: PlanStateStatus.loadedPlan, plan: success)));
    });

    on<LoadingPlansEvent>((event, emit) async {
      emit(state.copyWith(status: PlanStateStatus.loading));
    });

    on<LoadedPlansEvent>((event, emit) async {
      emit(state.copyWith(
          status: PlanStateStatus.loaded, plans: event.plans));
    });

    on<AddPlanEvent>((event, emit) async {
      emit(state.copyWith(status: PlanStateStatus.loading));

      final addedExercise = await planRepository.add(event.plan);

      addedExercise.fold(
              (failure) => emit(state.copyWith(status: PlanStateStatus.error)),
              (success) => add(AddedPlanEvent(success)));
    });

    on<AddedPlanEvent>((event, emit) async {
      emit(state.copyWith(status: PlanStateStatus.added, plan: event.plan));
    });

    on<UpdatePlanEvent>((event, emit) async {
      emit(state.copyWith(status: PlanStateStatus.loading));

      final addedPlan = await planRepository.update(event.plan);

      addedPlan.fold(
              (failure) => emit(state.copyWith(status: PlanStateStatus.error)),
              (success) => emit(state.copyWith(status: PlanStateStatus.updated, plan: success))
      );
    });

    on<DeletePlanEvent>((event, emit) async {
      emit(state.copyWith(status: PlanStateStatus.loading));

      final addedExercise = await planRepository.delete(event.planId);

      addedExercise.fold(
              (failure) => emit(state.copyWith(status: PlanStateStatus.error)),
              (success) => add(GetAllPlansEvent(refreshCache: true)));
    });

    on<LocalUpdatePlanEvent>((event, emit) async {

    });
  }
}
