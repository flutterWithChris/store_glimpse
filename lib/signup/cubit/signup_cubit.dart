import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_glimpse/auth/repository/auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignupState.initial());
  void signup({required String email, required String password}) async {
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      UserCredential userCredential =
          await _authRepository.signUpWithEmailAndPassword(email, password);
      emit(state.copyWith(status: SignupStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SignupStatus.error));
    }
  }
}
