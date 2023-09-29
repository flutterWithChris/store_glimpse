import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_glimpse/profile/model/user.dart';
import 'package:store_glimpse/stripe/repository/stripe_repository.dart';

part 'stripe_event.dart';
part 'stripe_state.dart';

class StripeBloc extends Bloc<StripeEvent, StripeState> {
  final StripeRepository _stripeRepository;
  StripeBloc({required StripeRepository stripeRepository})
      : _stripeRepository = stripeRepository,
        super(StripeInitial()) {
    on<LoadStripe>((event, emit) {});
    on<InitiatePurchase>((event, emit) async {
      emit(StripeLoading());
      await _stripeRepository.initiatePurchase(
          userID: event.user.id!, email: event.user.email!);
      emit(StripeLoaded());
    });
  }
}
