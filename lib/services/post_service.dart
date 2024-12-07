import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post_model.dart';
import '../utils/constants.dart';

class PostService {
  static const baseUrl = '${ApiConstants.baseUrl}/posts';

  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: await ApiConstants.getHeaders(),
      );

      print('GetPosts Response Status: ${response.statusCode}');
      print('GetPosts Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true && data['data'] != null) {
          return (data['data'] as List)
              .map((json) => Post.fromJson(json))
              .toList();
        }
        throw Exception('Invalid response format');
      }
      throw Exception('Failed to load posts: ${response.statusCode}');
    } catch (e) {
      print('Error in getPosts: $e');
      rethrow;
    }
  }

  Future<Post> createPost(String content) async {
    try {
      print('Creating post with content: $content');
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await ApiConstants.getHeaders(),
        body: jsonEncode({
          'content': content,
        }),
      );

      print('CreatePost Response Status: ${response.statusCode}');
      print('CreatePost Response Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true && data['data'] != null) {
          return Post.fromJson(data['data']);
        }
        throw Exception('Invalid response format');
      }
      throw Exception('Failed to create post: ${response.statusCode}');
    } catch (e) {
      print('Error in createPost: $e');
      rethrow;
    }
  }

  Future<void> likePost(String postId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$postId/like'),
        headers: await ApiConstants.getHeaders(),
      );

      print('LikePost Response Status: ${response.statusCode}');
      print('LikePost Response Body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to like post: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in likePost: $e');
      rethrow;
    }
  }
}
