part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  final User? user;
  const OnboardingEvent({this.user});

  @override
  List<Object?> get props => [user];
}

final class StartOnboarding extends OnboardingEvent {
  @override
  final User user;

  const StartOnboarding({required this.user});

  @override
  List<Object?> get props => [user];
}

final class UpdateUser extends OnboardingEvent {
  @override
  final User user;

  const UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

final class CompleteOnboarding extends OnboardingEvent {}
