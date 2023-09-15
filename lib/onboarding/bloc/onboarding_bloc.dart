import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_glimpse/profile/repository/user_respository.dart';
import 'package:store_glimpse/stripe/bloc/stripe_bloc.dart';

import '../../profile/model/user.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final UserRepository _userRepository;
  final StripeBloc _stripeBloc;
  OnboardingBloc(
      {required UserRepository userRepository, required StripeBloc stripeBloc})
      : _userRepository = userRepository,
        _stripeBloc = stripeBloc,
        super(OnboardingInitial()) {
    on<StartOnboarding>((event, emit) async {
      emit(OnboardingLoading());
      try {
        await _userRepository.createUser(event.user);

        _stripeBloc.add(InitiatePurchase(event.user));
        await Future.delayed(const Duration(seconds: 5));
        emit(OnboardingLoaded(user: event.user));
      } catch (e) {
        emit(OnboardingFailure(error: e.toString()));
      }
    });
    on<UpdateUser>((event, emit) async {
      emit(OnboardingLoading());
      try {
        await _userRepository.updateUser(event.user);
        emit(OnboardingLoaded(user: event.user));
      } catch (e) {
        emit(OnboardingFailure(error: e.toString()));
      }
    });
  }
}
