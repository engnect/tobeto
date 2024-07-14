import 'dart:convert';

class BlogModel {
  final String blogId;
  final String userId;
  final String userFullName;
  final DateTime blogCreatedAt;
  final String blogTitle;
  final String blogContent;
  final String blogImageUrl;
  BlogModel({
    required this.blogId,
    required this.userId,
    required this.userFullName,
    required this.blogCreatedAt,
    required this.blogTitle,
    required this.blogContent,
    required this.blogImageUrl,
  });

  BlogModel copyWith({
    String? blogId,
    String? userId,
    String? userFullName,
    DateTime? blogCreatedAt,
    String? blogTitle,
    String? blogContent,
    String? blogImageUrl,
  }) {
    return BlogModel(
      blogId: blogId ?? this.blogId,
      userId: userId ?? this.userId,
      userFullName: userFullName ?? this.userFullName,
      blogCreatedAt: blogCreatedAt ?? this.blogCreatedAt,
      blogTitle: blogTitle ?? this.blogTitle,
      blogContent: blogContent ?? this.blogContent,
      blogImageUrl: blogImageUrl ?? this.blogImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'blogId': blogId,
      'userId': userId,
      'userFullName': userFullName,
      'blogCreatedAt': blogCreatedAt,
      'blogTitle': blogTitle,
      'blogContent': blogContent,
      'blogImageUrl': blogImageUrl,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      blogId: map['blogId'] ?? '',
      userId: map['userId'] ?? '',
      userFullName: map['userFullName'] ?? '',
      blogCreatedAt: map['blogCreatedAt'].toDate() ?? '',
      blogTitle: map['blogTitle'] ?? '',
      blogContent: map['blogContent'] ?? '',
      blogImageUrl: map['blogImageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) =>
      BlogModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BlogModel(blogId: $blogId, userId: $userId, userFullName: $userFullName, blogCreatedAt: $blogCreatedAt, blogTitle: $blogTitle, blogContent: $blogContent, blogImageUrl: $blogImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BlogModel &&
        other.blogId == blogId &&
        other.userId == userId &&
        other.userFullName == userFullName &&
        other.blogCreatedAt == blogCreatedAt &&
        other.blogTitle == blogTitle &&
        other.blogContent == blogContent &&
        other.blogImageUrl == blogImageUrl;
  }

  @override
  int get hashCode {
    return blogId.hashCode ^
        userId.hashCode ^
        userFullName.hashCode ^
        blogCreatedAt.hashCode ^
        blogTitle.hashCode ^
        blogContent.hashCode ^
        blogImageUrl.hashCode;
  }
}
