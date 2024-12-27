part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocState {
  const AuthBlocState();
}

final class AuthInitialState extends AuthBlocState {}

final class AuthLoadingState extends AuthBlocState {}

final class AuthSuccesState extends AuthBlocState {
  final UserEntity user;

  const AuthSuccesState(this.user);
}

final class AuthFailureState extends AuthBlocState {
  final String message;

  const AuthFailureState(this.message);
}
