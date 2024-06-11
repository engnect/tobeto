part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogLoaded extends BlogState {
  final List<BlogModel> blogs;

  BlogLoaded({required this.blogs});
}

final class BlogSuccess extends BlogState {}

final class BlogFailed extends BlogState {}
