import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repos/auth_repo.dart';
import 'auth_state.dart';
import 'package:injectable/injectable.dart';


@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;

  AuthCubit({required this.repo}) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await repo.login(email: email, password: password);
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    emit(AuthLoading());
    final result = await repo.register(
      name: name,
      email: email,
      password: password,
      passwordConfirm: passwordConfirm,
    );
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(RegisterSuccess()),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final result = await repo.signInWithGoogle();
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(GoogleAuthSuccess(user)),
    );
  }
}