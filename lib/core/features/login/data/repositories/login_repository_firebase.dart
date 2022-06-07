import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:workout_watcher/core/error/failures.dart';
import 'package:workout_watcher/core/features/login/data/models/user_model.dart';
import 'package:workout_watcher/core/features/login/domain/repositorys/login_repository.dart';

class LoginRepositoryFirebase extends LoginRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  LoginRepositoryFirebase({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  @override
  Future<Either<Failure, UserModel>> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return right(_firebaseAuth.currentUser!.toUser);
    } catch (_) {
      return left(LoginFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> logIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return right(_firebaseAuth.currentUser!.toUser);
    } catch (_) {
      return left(LoginFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);

      return right(null);
    } catch (_) {
      return left(LoginFailure());
    }
  }
}

// extension to convert firebase User to own UserModel
extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(id: uid, email: email, name: displayName);
  }
}
