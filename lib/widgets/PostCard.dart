import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../controllers/post_controller.dart';
import '../controllers/auth_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatelessWidget {
  final Post post;
  final PostController postController = Get.find();
  final AuthController authController = Get.find();
  static const primaryBlue = Color(0xFF2563EB);

  PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentUser = authController.user.value;
      final isOwnPost = currentUser?.id == post.userId;

      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: post.userAvatar != null &&
                              post.userAvatar!.isNotEmpty
                          ? NetworkImage(post.userAvatar!)
                          : const AssetImage('assets/images/default_avatar.png')
                              as ImageProvider,
                      radius: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            timeago.format(post.createdAt, locale: 'id'),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isOwnPost)
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () => _showPostOptions(context),
                        splashRadius: 24,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                // Content
                Text(
                  post.content,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.grey.shade800,
                  ),
                ),
                if (post.images != null && post.images!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.network(
                          post.images!.first,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey.shade200,
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.grey.shade400),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey.shade100,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _buildActionButton(
                          icon: post.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          label: post.likeCount.toString(),
                          color:
                              post.isLiked ? Colors.red : Colors.grey.shade600,
                          onTap: () => _handleLike(),
                        ),
                        const SizedBox(width: 24),
                        _buildActionButton(
                          icon: Icons.comment_outlined,
                          label: post.commentCount.toString(),
                          onTap: () => _showComments(context),
                        ),
                      ],
                    ),
                    _buildActionButton(
                      icon: Icons.share_outlined,
                      label: 'Bagikan',
                      onTap: () => _handleShare(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Icon(icon, size: 20, color: color ?? Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: color ?? Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLike() async {
    try {
      await postController.likePost(post.id.toString());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menyukai postingan',
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red,
      );
    }
  }

  void _showComments(BuildContext context) {
    // TODO: Implement comments view
    Get.snackbar(
      'Info',
      'Fitur komentar akan segera hadir',
      backgroundColor: Colors.blue.shade50,
      colorText: Colors.blue,
    );
  }

  void _handleShare() {
    // TODO: Implement share functionality
    Get.snackbar(
      'Info',
      'Fitur bagikan akan segera hadir',
      backgroundColor: Colors.blue.shade50,
      colorText: Colors.blue,
    );
  }

  void _showPostOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text('Edit Postingan'),
                onTap: () {
                  Get.back();
                  _handleEdit();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Hapus Postingan'),
                onTap: () {
                  Get.back();
                  _handleDelete();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  void _handleEdit() {
    // TODO: Implement edit functionality
    Get.snackbar(
      'Info',
      'Fitur edit akan segera hadir',
      backgroundColor: Colors.blue.shade50,
      colorText: Colors.blue,
    );
  }

  void _handleDelete() {
    Get.dialog(
      AlertDialog(
        title: Text('Hapus Postingan'),
        content: Text('Apakah Anda yakin ingin menghapus postingan ini?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: Implement delete functionality
              Get.snackbar(
                'Info',
                'Fitur hapus akan segera hadir',
                backgroundColor: Colors.blue.shade50,
                colorText: Colors.blue,
              );
            },
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
