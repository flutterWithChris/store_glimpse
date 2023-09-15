part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  const AuthState({this.status = AuthStatus.unknown, this.user});

  const AuthState.initial() : this(status: AuthStatus.unknown);

  const AuthState.authenticated(User user)
      : this(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);

  @override
  List<Object> get props => [status];
}
