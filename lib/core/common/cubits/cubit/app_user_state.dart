part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitialState extends AppUserState {}

final class AppUserLoggedInState extends AppUserState {
  final UserEntity user;

  AppUserLoggedInState(this.user);
}

// core not depend on other features
// other features can depend on core
