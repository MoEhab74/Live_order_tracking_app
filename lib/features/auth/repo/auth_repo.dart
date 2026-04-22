import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practical_google_maps_example/core/utils/service_locator.dart';
import 'package:practical_google_maps_example/features/auth/models/user_model.dart';

class AuthRepo {
  Future<Either<String, UserModel>> registerUser(
      String username, String email, String password) async {
    try {
      UserCredential user =
          await sl<FirebaseAuth>().createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("User registered :  ${user.user!.uid}");
      await sl<FirebaseFirestore>()
          .collection('users')
          .doc(user.user!.uid)
          .set({
        'uid': user.user!.uid,
        'username': username,
        'email': email,
      });
      // Save user data as UserModel by using fromJson constructor
      Map<String, dynamic> userData = {
        'uid': user.user!.uid,
        'username': username,
        'email': email,
      };
      UserModel registeredUser = UserModel.fromJson(userData);
      return Right(registeredUser);
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleFirebaseSignUpException(e);
      return Left(errorMessage);
    } catch (e) {
      log(e.toString());
      return const Left('An unexpected error occurred.');
    }
  }

  Future<Either<String, UserModel>> loginUser(
      String email, String password) async {
    try {
      UserCredential user = await sl<FirebaseAuth>().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Find the user in Firestore
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await sl<FirebaseFirestore>()
              .collection('users')
              .doc(user.user!.uid)
              .get();
      // get userSnapshot data
      if (!userSnapshot.exists) {
        return const Left('User data not found in Firestore.');
      }
      Map<String, dynamic> userData = userSnapshot.data()!;
      // Convert userData to UserModel by using fromJson constructor
      UserModel loggedInUser =  UserModel.fromJson(userData);

      log("User logged in :  ${user.user!.uid}");
      return Right(loggedInUser);
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleFirebaseLoginException(e);
      return Left(errorMessage);
    } catch (e) {
      log(e.toString());
      return const Left('An unexpected error occurred.');
    }
  }

  // get the current user from firebase auth and return it as UserModel
  Future<Either<String, UserModel>> getCurrentUser() async {
    try{
      User? user = sl<FirebaseAuth>().currentUser;
      if (user == null) {
        return const Left('No user found.');
      }
      // Find the user in Firestore
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await sl<FirebaseFirestore>()
          .collection('users')
          .doc(user.uid)
          .get();
      if (!userSnapshot.exists) {
        return const Left('User data not found in Firestore.');
      }
      Map<String, dynamic> userData = userSnapshot.data()!;
      UserModel currentUser = UserModel.fromJson(userData);
      return Right(currentUser);
    } catch (e) {
      log(e.toString());
      return const Left('An unexpected error occurred.');
    }
  }

  String _handleFirebaseSignUpException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'network-request-failed':
        return 'A network error has occurred. Please check your internet connection and try again.';
      default:
        return 'An unexpected error occurred. Please try again later.';
    }
  }

  String _handleFirebaseLoginException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'network-request-failed':
        return 'A network error has occurred. Please check your internet connection and try again.';
      default:
        return 'An unexpected error occurred. Please try again later.';
    }
  }
}
