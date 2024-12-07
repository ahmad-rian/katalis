import 'package:flutter/material.dart';

class CreatePostCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String avatarUrl;

  const CreatePostCard({
    Key? key,
    required this.onPressed,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.grey.shade100,
                ),
                child: Text(
                  'Apa yang ingin Anda bagikan?',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CreatePostButton(
              onPressed: onPressed,
              backgroundColor: Colors.grey.shade300,
              icon: Icons.edit, // Sesuaikan ikon sesuai kebutuhan.
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}

class CreatePostButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double elevation;
  final IconData icon;

  const CreatePostButton({
    Key? key,
    required this.onPressed,
    this.backgroundColor,
    this.elevation = 2.0,
    this.icon = Icons.add,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      elevation: elevation,
      mini: true, // Untuk ukuran kecil agar lebih cocok dengan desain card.
      child: Icon(
        icon,
        color: Colors.black54, // Warna ikon sesuai tema.
      ),
    );
  }
}
