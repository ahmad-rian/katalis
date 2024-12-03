import 'package:flutter/material.dart';

class SearchNimPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Masukkan NIM Mahasiswa:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'NIM',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implementasikan logika pencarian NIM di sini
            },
            child: Text('Cari'),
          ),
        ],
      ),
    );
  }
}
