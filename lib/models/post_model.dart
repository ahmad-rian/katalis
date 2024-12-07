class Post {
  final int id;
  final int userId;
  final String content;
  final DateTime createdAt;
  final String userName;
  final String? userAvatar;
  final List<String>? images;
  final int likeCount;
  final int commentCount;
  final bool isLiked;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.userName,
    this.userAvatar,
    this.images,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isLiked = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      userName: json['user']['name'],
      userAvatar: json['user']['avatar'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      likeCount: json['like_count'] ?? 0,
      commentCount: json['comment_count'] ?? 0,
      isLiked: json['is_liked'] ?? false,
    );
  }

  Post copyWith({
    int? id,
    int? userId,
    String? content,
    DateTime? createdAt,
    String? userName,
    String? userAvatar,
    List<String>? images,
    int? likeCount,
    int? commentCount,
    bool? isLiked,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      images: images ?? this.images,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
