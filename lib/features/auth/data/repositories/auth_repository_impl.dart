// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_bloc_app/core/constants/constants.dart';
import 'package:fpdart/fpdart.dart';

import 'package:blog_bloc_app/core/common/entities/user_entity.dart';
import 'package:blog_bloc_app/core/error/failure.dart';
import 'package:blog_bloc_app/core/error/server_exception.dart';
import 'package:blog_bloc_app/core/network/connection_checker.dart';
import 'package:blog_bloc_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_bloc_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(
    this.authRemoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, UserEntity>> currentUser() {
    return _getUser(
      () async => await authRemoteDataSource.getCurrentUserData(),
      checkSession: true,
    );
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity?> Function() fn, {
    bool checkSession = false,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        if (checkSession) {
          final session = authRemoteDataSource.currentUserSession;
          if (session == null) {
            return left(Failure(Constants.userNotLoggedIn));
          }

          return right(
            UserEntity(
              id: session.user.id,
              email: session.user.email ?? '',
              name: '',
            ),
          );
        }

        return left(Failure(Constants.noConnectionErrorMessage));
      }

      final user = await fn();

      if (checkSession && user == null) {
        return left(Failure(Constants.userNotLoggedIn));
      }

      return right(user!);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      final String err = e.toString();
      return left(Failure(err));
    }
  }
}
