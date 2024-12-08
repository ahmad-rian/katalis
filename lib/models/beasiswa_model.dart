class BeasiswaModel {
  final int id;
  final String namaBeasiswa;
  final String deskripsi;
  final String jenis;
  final String? gambar;

  BeasiswaModel({
    required this.id,
    required this.namaBeasiswa,
    required this.deskripsi,
    required this.jenis,
    this.gambar,
  });

  factory BeasiswaModel.fromJson(Map<String, dynamic> json) {
    return BeasiswaModel(
      id: json['id'],
      namaBeasiswa: json['nama_beasiswa'],
      deskripsi: json['deskripsi'],
      jenis: json['jenis'],
      gambar: json['gambar'],
    );
  }
}
