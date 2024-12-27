// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:blog_bloc_app/core/constants/constants.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:blog_bloc_app/core/error/failure.dart';
import 'package:blog_bloc_app/core/error/server_exception.dart';
import 'package:blog_bloc_app/core/network/connection_checker.dart';
import 'package:blog_bloc_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_bloc_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_bloc_app/features/blog/data/models/blog_model.dart';
import 'package:blog_bloc_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_bloc_app/features/blog/domain/repository/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      final String err = e.toString();
      throw left(Failure(err));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlog() async {
    List<BlogEntity> blogs = [];

    try {
      if (await connectionChecker.isConnected) {
        blogs = await blogRemoteDataSource.getAllBlog();
        blogLocalDataSource.uploadLocalBlogs(blogs: blogs as List<BlogModel>);
      } else {
        blogs = blogLocalDataSource.loadBlogs();
      }
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      final String err = e.toString();
      throw left(Failure(err));
    }
  }
}
