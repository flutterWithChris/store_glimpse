import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_glimpse/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.initial()) {
    _authRepository.user.listen((user) => add(AuthUserChanged(user: user)));

    on<AuthUserChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthState.authenticated(event.user!));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }
}
