import 'package:flutter/material.dart';

class AnnouncementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: 5, // Misalnya 5 pengumuman
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text('Pengumuman ${index + 1}'),
              subtitle: Text('Isi pengumuman...'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Implementasikan aksi saat pengumuman dipilih
              },
            ),
          );
        },
      ),
    );
  }
}
