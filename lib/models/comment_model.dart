class Comment {
  final int id;
  final int userId;
  final int postId;
  final String content;
  final String userName;
  final String? userAvatar;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.userId,
    required this.postId,
    required this.content,
    required this.userName,
    this.userAvatar,
    required this.createdAt,
  });

  /// Membuat objek [Comment] dari map JSON.
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      postId: json['post_id'] as int,
      content: json['content'] as String,
      userName: json['user']['name'] as String,
      userAvatar: json['user']['avatar'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// Mengonversi objek [Comment] menjadi map JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'post_id': postId,
      'content': content,
      'user': {
        'name': userName,
        'avatar': userAvatar,
      },
      'created_at': createdAt.toIso8601String(),
    };
  }
}
