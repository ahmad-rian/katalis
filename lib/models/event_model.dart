class EventModel {
  final int id;
  final String namaEvent;
  final String deskripsi;
  final String jenis;
  final String? gambar;

  EventModel({
    required this.id,
    required this.namaEvent,
    required this.deskripsi,
    required this.jenis,
    this.gambar,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      namaEvent: json['nama_event'],
      deskripsi: json['deskripsi'],
      jenis: json['jenis'],
      gambar: json['gambar'],
    );
  }
}
