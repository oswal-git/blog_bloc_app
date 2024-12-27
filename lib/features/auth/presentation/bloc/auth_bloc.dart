// ignore_for_file: avoid_print

import 'dart:async';
import 'package:blog_bloc_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blog_bloc_app/core/common/entities/no_params.dart';
import 'package:blog_bloc_app/core/common/entities/user_entity.dart';
import 'package:blog_bloc_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_bloc_app/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:blog_bloc_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final UserSignUpUseCase _userSignUp;
  final UserLoginUseCase _userLogin;
  final CurrentUserUsecase _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUpUseCase userSignUp,
    required UserLoginUseCase userLogin,
    required CurrentUserUsecase currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitialState()) {
    on<AuthEvent>((_, emit) => emit(AuthLoadingState()));
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedInEvent);
  }

  Future<void> _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthBlocState> emit) async {
    final res = await _userSignUp(UserSignUpParams(name: event.name, email: event.email, password: event.password));

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => _emitAuthSuccessEvent(user, emit),
    );
  }

  Future<void> _onAuthLogin(AuthLoginEvent event, Emitter<AuthBlocState> emit) async {
    final res = await _userLogin(UserLoginParams(email: event.email, password: event.password));

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => _emitAuthSuccessEvent(user, emit),
    );
  }

  Future<void> _onAuthIsUserLoggedInEvent(AuthIsUserLoggedInEvent event, Emitter<AuthBlocState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => _emitAuthSuccessEvent(user, emit),
    );
  }

  void _emitAuthSuccessEvent(UserEntity user, Emitter<AuthBlocState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccesState(user));
  }
}
