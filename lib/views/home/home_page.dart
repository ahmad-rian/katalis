import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katalis/widgets/PostCard.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/post_controller.dart';
import '../../widgets/create_post_card.dart';

class HomePage extends StatelessWidget {
  final PostController postController = Get.put(PostController());
  final AuthController authController = Get.find<AuthController>();
  static const primaryBlue = Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => postController.fetchPosts(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Feed Anda',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(() {
                        final user = authController.user.value;
                        return CreatePostCard(
                          avatarUrl: user?.avatar ??
                              'assets/images/default_avatar.png',
                          onPressed: () => _showCreatePostDialog(context),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Obx(() {
                if (postController.isLoading.value &&
                    postController.posts.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (postController.posts.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(child: Text('Belum ada postingan')),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = postController.posts[index];
                      return PostCard(post: post);
                    },
                    childCount: postController.posts.length,
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    final textController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 500,
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Buat Postingan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              Divider(),
              const SizedBox(height: 16),
              TextField(
                controller: textController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Apa yang ingin Anda bagikan?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text('Batal'),
                  ),
                  const SizedBox(width: 8),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: postController.isCreating.value
                          ? null
                          : () {
                              if (textController.text.trim().isNotEmpty) {
                                postController.createPost(textController.text);
                              }
                            },
                      child: postController.isCreating.value
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text('Posting'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
