import 'package:dartz/dartz.dart';
import 'package:workout_watcher/core/error/failures.dart';
import 'package:workout_watcher/core/login/data/models/user_model.dart';

abstract class LoginRepository {
  UserModel currentUser = UserModel.empty;

  Future<Either<Failure, UserModel>> signUp(String email, String password);
  Future<Either<Failure, UserModel>> logIn(String email, String password);
  Future<Either<Failure, void>> logOut();
}