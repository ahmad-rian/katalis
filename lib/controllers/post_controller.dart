import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../services/post_service.dart';

class PostController extends GetxController {
  final RxList<Post> posts = <Post>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isCreating = false.obs;
  final PostService _postService = Get.find<PostService>();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final newPosts = await _postService.getPosts();
      posts.assignAll(newPosts);
    } catch (e) {
      _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createPost(String content) async {
    if (content.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Konten tidak boleh kosong',
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red,
      );
      return;
    }

    try {
      isCreating.value = true;
      final post = await _postService.createPost(content);
      posts.insert(0, post);
      Get.back();
      Get.snackbar(
        'Sukses',
        'Postingan berhasil dibuat',
        backgroundColor: Colors.green.shade50,
        colorText: Colors.green,
      );
    } catch (e) {
      _handleError(e);
    } finally {
      isCreating.value = false;
    }
  }

  Future<void> likePost(String postId) async {
    try {
      await _postService.likePost(postId);
      final index = posts.indexWhere((post) => post.id.toString() == postId);
      if (index != -1) {
        final post = posts[index];
        posts[index] = post.copyWith(
          likeCount: post.isLiked ? post.likeCount - 1 : post.likeCount + 1,
          isLiked: !post.isLiked,
        );
      }
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(dynamic error) {
    print('Error: $error');
    Get.snackbar(
      'Error',
      error.toString(),
      backgroundColor: Colors.red.shade50,
      colorText: Colors.red,
      duration: Duration(seconds: 5),
    );
  }
}
