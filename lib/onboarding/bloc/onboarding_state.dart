part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  final User? user;
  const OnboardingState({this.user});

  @override
  List<Object?> get props => [user];
}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingLoaded extends OnboardingState {
  @override
  final User user;

  const OnboardingLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

final class OnboardingCompleted extends OnboardingState {}

final class OnboardingFailure extends OnboardingState {
  final String error;

  const OnboardingFailure({required this.error});

  @override
  List<Object> get props => [error];
}
