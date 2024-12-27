import 'package:blog_bloc_app/core/common/entities/no_params.dart';
import 'package:blog_bloc_app/core/error/failure.dart';
import 'package:blog_bloc_app/core/usecase/use_case.dart';
import 'package:blog_bloc_app/core/common/entities/user_entity.dart';
import 'package:blog_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserUsecase implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  CurrentUserUsecase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
