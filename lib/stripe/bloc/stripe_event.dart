part of 'stripe_bloc.dart';

sealed class StripeEvent extends Equatable {
  final User? user;
  const StripeEvent({this.user});

  @override
  List<Object?> get props => [user];
}

final class LoadStripe extends StripeEvent {}

final class InitiatePurchase extends StripeEvent {
  @override
  final User user;

  const InitiatePurchase(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
