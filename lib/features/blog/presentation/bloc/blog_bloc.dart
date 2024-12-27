import 'dart:async';
import 'dart:io';

import 'package:blog_bloc_app/core/common/entities/no_params.dart';
import 'package:blog_bloc_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_bloc_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:blog_bloc_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;
  final GetAllBlogsUseCase _getAllBlogsUseCase;
  BlogBloc({
    required UploadBlogUseCase uploadBlogUseCase,
    required GetAllBlogsUseCase getAllBlogsUseCase,
  })  : _uploadBlogUseCase = uploadBlogUseCase,
        _getAllBlogsUseCase = getAllBlogsUseCase,
        super(BlogInitialState()) {
    on<BlogEvent>((event, emit) => emit(BlogInitialState()));
    on<BlogUploadEvent>(_onBlogUploadEvent);
    on<GetAllBlogEvent>(_onGetAllBlogEvent);
  }

  FutureOr<void> _onBlogUploadEvent(
    BlogUploadEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _uploadBlogUseCase(
      UploadBlogParams(
        image: event.image,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics,
      ),
    );

    res.fold(
      (error) => emit(BlogFailureState(error.message)),
      (blogEntity) => emit(
        BlogUploadSuccessState(),
      ),
    );
  }

  Future<void> _onGetAllBlogEvent(
    GetAllBlogEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogsUseCase(NoParams());

    res.fold(
      (error) => emit(BlogFailureState(error.message)),
      (blogs) => emit(
        BlogDisplaySuccessState(blogs),
      ),
    );
  }
}
