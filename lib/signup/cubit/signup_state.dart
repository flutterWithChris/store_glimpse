part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final SignupStatus status;
  const SignupState({required this.status});

  @override
  List<Object?> get props => [status];

  SignupState copyWith({SignupStatus? status}) {
    return SignupState(status: status ?? this.status);
  }

  const SignupState.initial() : this(status: SignupStatus.initial);

  const SignupState.submitting() : this(status: SignupStatus.submitting);

  const SignupState.success() : this(status: SignupStatus.success);

  const SignupState.error() : this(status: SignupStatus.error);
}
