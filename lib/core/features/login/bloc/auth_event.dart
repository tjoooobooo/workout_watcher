import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:workout_watcher/core/features/login/data/models/user_model.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStartedEvent extends AuthEvent {}

class RegistrationModeEvent extends AuthEvent {}

class LoginModeEvent extends AuthEvent {}

class LogInEvent extends AuthEvent {
  final String email;
  final String password;

  LogInEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LoggedInEvent extends AuthEvent {
  final UserModel user;

  LoggedInEvent(this.user);

  @override
  List<Object> get props => [user];
}

class LogOutEvent extends AuthEvent {}
