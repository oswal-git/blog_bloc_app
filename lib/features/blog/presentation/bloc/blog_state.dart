part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitialState extends BlogState {}

final class BlogLoadingState extends BlogState {}

final class BlogUploadSuccessState extends BlogState {}

final class BlogDisplaySuccessState extends BlogState {
  final List<BlogEntity> blogs;

  BlogDisplaySuccessState(this.blogs);
}

final class BlogFailureState extends BlogState {
  final String message;

  BlogFailureState(this.message);
}
