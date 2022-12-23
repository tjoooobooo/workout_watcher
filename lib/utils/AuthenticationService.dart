import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/main.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;

  AuthenticationService(this.firebaseAuth);

  Stream<User?> get authStateChanges => firebaseAuth.idTokenChanges();

  Future<String> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return "Signed in";

    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signUp({required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      await signIn(email: email, password: password);

      return "Signed up";

    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<void> userSetup({required String name}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User user = firebaseAuth.currentUser!;

    firestore.collection("Users").doc(user.uid).set(
        {
          "uid": user.uid,
          "name": name
        }
    );
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }
}