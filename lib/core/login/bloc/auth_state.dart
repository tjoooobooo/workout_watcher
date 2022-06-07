import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:workout_watcher/core/login/data/models/user_model.dart';

enum AuthStateStatus {
  login,
  loggedIn,
  registration,
  loading,
  error,
}

extension AuthStateStatusX on AuthStateStatus {
  bool get isLogin => this == AuthStateStatus.login;

  bool get isRegistration => this == AuthStateStatus.registration;

  bool get isLoading => this == AuthStateStatus.loading;

  bool get isLoggedIn => this == AuthStateStatus.loggedIn;

  bool get isError => this == AuthStateStatus.error;
}

@immutable
class AuthState extends Equatable {
  final AuthStateStatus status;
  final UserModel user;

  const AuthState({
    this.status = AuthStateStatus.login,
    this.user = UserModel.empty,
  });

  @override
  List<Object> get props => [status, UserModel.empty];

  AuthState copyWith({AuthStateStatus? status, UserModel user = UserModel.empty}) {
    return AuthState(status: status ?? this.status, user: user);
  }
}
