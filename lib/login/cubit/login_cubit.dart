import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_glimpse/auth/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginInitial());
  void loginWithEmailAndPassword(
          {required String email, required String password}) =>
      _onLoginWithEmailAndPassword(email: email, password: password);
  void logout() => _onLogout();

  _onLoginWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await _authRepository.signInWithEmailAndPassword(email, password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  _onLogout() async {
    await _authRepository.signOut();
    emit(LoginInitial());
  }
}
