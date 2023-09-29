part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  final User? user;
  const ProfileState({this.user});

  @override
  List<Object?> get props => [user];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  @override
  final User user;

  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

final class ProfileError extends ProfileState {
  final String error;

  const ProfileError(this.error);

  @override
  List<Object?> get props => [error];
}
