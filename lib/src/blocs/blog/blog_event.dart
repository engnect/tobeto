part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class FetchAllBlogs extends BlogEvent {
  final bool isBlog;

  FetchAllBlogs({required this.isBlog});
}

final class AddBlog extends BlogEvent {
  final bool isBlog;
  final BlogModel blogModel;
  AddBlog({required this.isBlog, required this.blogModel});
}

final class UpdateBlog extends BlogEvent {
  final bool isBlog;
  final BlogModel blogModel;
  UpdateBlog({required this.isBlog, required this.blogModel});
}

final class DeleteBlog extends BlogEvent {
  final bool isBlog;
  final BlogModel blogModel;
  DeleteBlog({required this.isBlog, required this.blogModel});
}
