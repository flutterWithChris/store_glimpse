import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_glimpse/profile/model/user.dart';
import 'package:store_glimpse/profile/repository/user_respository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
  }
  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await emit.forEach(
        _userRepository.getUser(event.userID),
        onData: (data) {
          return ProfileLoaded(data);
        },
        onError: (error, stackTrace) {
          return ProfileError(error.toString());
        },
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
      print(e);
    }
  }
}
