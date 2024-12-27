// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:blog_bloc_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_bloc_app/features/blog/domain/repository/blog_repository.dart';

import 'package:blog_bloc_app/core/error/failure.dart';
import 'package:blog_bloc_app/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUseCase implements UseCase<BlogEntity, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlogUseCase(this.blogRepository);

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;
  UploadBlogParams({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
  });
}
