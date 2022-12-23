import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ""});

  @override
  List<Object?> get props => [];
}

class NoFailure extends Failure {}

class LoginFailure extends Failure {
  const LoginFailure({String message = ""}): super (message: message);
}

class DBFailure extends Failure {}

class NoExerciseFoundFailure extends Failure {}