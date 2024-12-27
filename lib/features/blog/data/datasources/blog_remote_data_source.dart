import 'dart:io';

import 'package:blog_bloc_app/core/error/server_exception.dart';
import 'package:blog_bloc_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlog();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } on AuthException catch (authException) {
      throw ServerException(authException.message);
    } on PostgrestException catch (postgrestException) {
      throw ServerException(postgrestException.message);
    } catch (e) {
      final String err = e.toString();
      throw ServerException(err);
    }
  }

  @override
  Future<String> uploadBlogImage({required File image, required BlogModel blog}) async {
    try {
      final String pathImage = blog.id;

      await supabaseClient.storage.from('blog_images').upload(
            pathImage,
            image,
          );
      final String pathStored = supabaseClient.storage.from('blog_images').getPublicUrl(pathImage);
      return pathStored;
    } on StorageException catch (storageException) {
      throw ServerException(storageException.message);
    } on AuthException catch (authException) {
      throw ServerException(authException.message);
    } catch (e) {
      final String err = e.toString();
      throw ServerException(err);
    }
  }

  @override
  Future<List<BlogModel>> getAllBlog() async {
    try {
      final blogs = await supabaseClient.from('blogs').select('*, profiles(name)');
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              posterName: blog['profiles']['name'],
            ),
          )
          .toList();
    } on AuthException catch (authException) {
      throw ServerException(authException.message);
    } catch (e) {
      final String err = e.toString();
      throw ServerException(err);
    }
  }
}
