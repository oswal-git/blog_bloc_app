import 'package:blog_bloc_app/core/error/failure.dart';
import 'package:blog_bloc_app/core/usecase/use_case.dart';
import 'package:blog_bloc_app/core/common/entities/user_entity.dart';
import 'package:blog_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUpUseCase implements UseCase<UserEntity, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUpUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({required this.name, required this.email, required this.password});
}
