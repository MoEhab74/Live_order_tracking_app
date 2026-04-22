import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_google_maps_example/core/utils/service_locator.dart';
import 'package:practical_google_maps_example/features/auth/cubit/auth_state.dart';
import 'package:practical_google_maps_example/features/auth/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthRepo _authRepo = sl<AuthRepo>();

  Future<void> registerUser(
      String username, String email, String password) async {
    emit(AuthLoading());
    final result = await _authRepo.registerUser(username, email, password);
    result.fold(
      (error) => emit(AuthError(error)),
      (user) => emit(AuthSuccess('User registered successfully.', user)),
    );
  }

  Future<void> loginUser(String email, String password) async {
    emit(AuthLoading());
    final result = await _authRepo.loginUser(email, password);
    result.fold(
      (error) => emit(AuthError(error)),
      (user) => emit(AuthSuccess('User logged in successfully.', user)),
    );
  }
}
