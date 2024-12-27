import 'package:blog_bloc_app/core/error/failure.dart';
import 'package:blog_bloc_app/core/usecase/use_case.dart';
import 'package:blog_bloc_app/core/common/entities/user_entity.dart';
import 'package:blog_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginUseCase implements UseCase<UserEntity, UserLoginParams> {
  final AuthRepository authRepository;

  UserLoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
