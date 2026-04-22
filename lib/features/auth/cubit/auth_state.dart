import 'package:practical_google_maps_example/features/auth/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  final UserModel user;

  AuthSuccess(this.message, this.user);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}