import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/domain/repositories/blog_repository.dart';
import 'package:tobeto/src/models/blog_model.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository _blogRepository;
  BlogBloc(this._blogRepository) : super(BlogInitial()) {
    on<FetchAllBlogs>((event, emit) async {
      emit(BlogLoading());

      try {
        if (event.isBlog == true) {
          final blogs = await _blogRepository.fetchBlogsFromFirestore();
          emit(BlogLoaded(blogs: blogs));
        } else {
          final blogs = await _blogRepository.fetchBlogsFromFirestore();
          emit(BlogLoaded(blogs: blogs));
        }
      } catch (_) {
        emit(BlogFailed());
      }
    });

    on<AddBlog>((event, emit) async {
      emit(BlogLoading());

      try {
        if (event.isBlog == true) {
          await _blogRepository.addOrUpdateBlog(blogModel: event.blogModel);
          emit(BlogSuccess());
        } else {
          await _blogRepository.addOrUpdateBlog(blogModel: event.blogModel);
          emit(BlogSuccess());
        }
      } catch (_) {
        emit(BlogFailed());
      }
    });

    on<UpdateBlog>((event, emit) async {
      emit(BlogLoading());

      try {
        if (event.isBlog == true) {
          await _blogRepository.addOrUpdateBlog(blogModel: event.blogModel);
          emit(BlogSuccess());
        } else {
          await _blogRepository.addOrUpdateBlog(blogModel: event.blogModel);
          emit(BlogSuccess());
        }
      } catch (_) {
        emit(BlogFailed());
      }
    });

    on<DeleteBlog>((event, emit) async {
      emit(BlogLoading());

      try {
        if (event.isBlog == true) {
          await _blogRepository.deleteBlog(blogModel: event.blogModel);
          emit(BlogSuccess());
        } else {
          await _blogRepository.deleteBlog(blogModel: event.blogModel);
          emit(BlogSuccess());
        }
      } catch (_) {
        emit(BlogFailed());
      }
    });
  }
}
