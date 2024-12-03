import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Menyimpan bio yang dimasukkan oleh pengguna
  String _bio = "Ini adalah bio default.";

  // Menyimpan teks yang dimasukkan dalam TextField
  TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bioController.text = _bio; // Menampilkan bio yang sudah ada pada saat awal
  }

  @override
  void dispose() {
    _bioController.dispose(); // Membersihkan controller saat halaman di-dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle,
            size: 100,
            color: Colors.blue,
          ),
          SizedBox(height: 20),
          Text(
            'Nama Pengguna',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Email: pengguna@example.com'),
          SizedBox(height: 20),

          // Menambahkan bagian untuk Bio
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _bioController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
                hintText: 'Tambahkan bio Anda...',
              ),
              onChanged: (text) {
                setState(() {
                  _bio = text; // Menyimpan bio yang dimasukkan
                });
              },
            ),
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              // Aksi saat tombol Edit Profile ditekan
              // Misalnya bisa digunakan untuk menyimpan bio atau melakukan pengaturan lainnya
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Bio Updated'),
                    content: Text('Bio berhasil diperbarui: $_bio'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}
