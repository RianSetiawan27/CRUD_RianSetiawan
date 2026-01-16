import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pegawai.dart';
import 'api.dart';

class PegawaiService {

  /// GET semua pegawai
  static Future<List<Pegawai>> getPegawai() async {
    final response = await http.get(
      Uri.parse("${Api.baseUrl}/pegawai"),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Pegawai.fromJson(e)).toList();
    } else {
      throw Exception(
        'Gagal mengambil data (${response.statusCode}) : ${response.body}',
      );
    }
  }

  /// POST tambah pegawai
  static Future<void> addPegawai(Pegawai pegawai) async {
    final response = await http.post(
      Uri.parse("${Api.baseUrl}/pegawai"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(pegawai.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception(
        'Gagal menambah pegawai (${response.statusCode}) : ${response.body}',
      );
    }
  }

  /// PUT update pegawai
  static Future<void> updatePegawai(int id, Pegawai pegawai) async {
    final response = await http.put(
      Uri.parse("${Api.baseUrl}/pegawai/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(pegawai.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengubah pegawai (${response.statusCode}) : ${response.body}',
      );
    }
  }

  /// DELETE pegawai
  static Future<void> deletePegawai(int id) async {
    final response = await http.delete(
      Uri.parse("${Api.baseUrl}/pegawai/$id"),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal menghapus pegawai (${response.statusCode}) : ${response.body}',
      );
    }
  }
}
