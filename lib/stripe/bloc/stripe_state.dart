part of 'stripe_bloc.dart';

sealed class StripeState extends Equatable {
  const StripeState();

  @override
  List<Object> get props => [];
}

final class StripeInitial extends StripeState {}

final class StripeLoading extends StripeState {}

final class StripeLoaded extends StripeState {}

final class StripeError extends StripeState {
  final String message;

  const StripeError(this.message);

  @override
  List<Object> get props => [message];
}
