part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  final String? userID;
  const ProfileEvent({this.userID});

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  @override
  String userID;
  LoadProfile({required this.userID});
}
