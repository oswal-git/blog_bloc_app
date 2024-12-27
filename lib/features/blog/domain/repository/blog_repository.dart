import 'dart:io';

import 'package:blog_bloc_app/core/error/failure.dart';
import 'package:blog_bloc_app/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
  Future<Either<Failure, List<BlogEntity>>> getAllBlog();
}
