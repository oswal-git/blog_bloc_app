import 'package:blog_bloc_app/core/common/entities/no_params.dart';
import 'package:blog_bloc_app/core/error/failure.dart';
import 'package:blog_bloc_app/core/usecase/use_case.dart';
import 'package:blog_bloc_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUseCase implements UseCase<List<BlogEntity>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogsUseCase(this.blogRepository);

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return await blogRepository.getAllBlog();
  }
}
