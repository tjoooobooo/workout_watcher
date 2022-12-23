import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_watcher/core/features/login/bloc/bloc.dart';
import 'package:workout_watcher/core/features/login/data/models/user_model.dart';
import 'package:workout_watcher/core/features/login/domain/repositorys/login_repository.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> with ChangeNotifier {
  final LoginRepository loginRepository;
  StreamSubscription<UserModel>? userSubscription;

  AuthBloc(this.loginRepository)
      : super(loginRepository.currentUser.isNotEmpty
            ? AuthState(status: AuthStateStatus.loggedIn, user: loginRepository.currentUser)
            : const AuthState(status: AuthStateStatus.login)) {
    @override
    Future<void> close() {
      userSubscription?.cancel();
      return super.close();
    }

    on<AppStartedEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStateStatus.login));
    });

    on<LogInEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStateStatus.loading));
      final user = await loginRepository.logIn(event.email, event.password);

      emit(state.copyWith(status: AuthStateStatus.loggedIn));
      notifyListeners();
      // user.fold(
      //   (failure) => emit(state.copyWith(status: AuthStateStatus.error, message: failure.message)),
      //   (success) => emit(
      //       state.copyWith(status: AuthStateStatus.loggedIn, user: success)),
      // );
    });

    on<LoggedInEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStateStatus.loggedIn, user: event.user));
    });

    on<LogOutEvent>(((event, emit) async {
      final logout = await loginRepository.logOut();
      logout.fold(
          (failure) => emit(state.copyWith(status: AuthStateStatus.login, user: UserModel.empty)),
          (success) {
        emit(state.copyWith(status: AuthStateStatus.login, user: UserModel.empty));
        notifyListeners();
      });
    }));

    on<RegistrationModeEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStateStatus.registration));
    });

    on<LoginModeEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStateStatus.login));
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final status = EnumToString.fromString(AuthStateStatus.values, json['status'])!;
    final user = UserModel.fromJson(json['user']);
    return AuthState(status: status, user: user);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {'status': EnumToString.convertToString(state.status), 'user': state.user.toJson()};
  }
}
