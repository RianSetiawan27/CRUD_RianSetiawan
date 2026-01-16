class Pegawai {
  final int? id;
  final String nip;
  final String nama;
  final String jabatan;
  final String departemen;
  final String noHp;
  final String email;
  final String alamat;

  Pegawai({
    this.id,
    required this.nip,
    required this.nama,
    required this.jabatan,
    required this.departemen,
    required this.noHp,
    required this.email,
    required this.alamat,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json['id'],
      nip: json['nip'],
      nama: json['nama'],
      jabatan: json['jabatan'],
      departemen: json['departemen'],
      noHp: json['no_hp'] ?? '',
      email: json['email'] ?? '',
      alamat: json['alamat'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nip': nip,
      'nama': nama,
      'jabatan': jabatan,
      'departemen': departemen,
      'no_hp': noHp,
      'email': email,
      'alamat': alamat,
    };
  }
}
