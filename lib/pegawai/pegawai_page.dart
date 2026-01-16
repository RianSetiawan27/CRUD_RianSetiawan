import 'package:flutter/material.dart';
import '../models/pegawai.dart';
import '../services/pegawai_service.dart';
import 'form_pegawai_page.dart';
import 'pegawai_card.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({super.key});

  @override
  State<PegawaiPage> createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  late Future<List<Pegawai>> futurePegawai;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    futurePegawai = PegawaiService.getPegawai();
  }

  void refresh() {
    setState(() {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFA855F7),
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormPegawaiPage()),
          );
          refresh();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: FutureBuilder<List<Pegawai>>(
                future: futurePegawai,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Gagal memuat data",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  final data = snapshot.data!;
                  if (data.isEmpty) {
                    return const Center(
                      child: Text(
                        "Data masih kosong",
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final p = data[index];
                      return PegawaiCard(
                        pegawai: p,
                        onEdit: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FormPegawaiPage(pegawai: p),
                            ),
                          );
                          refresh();
                        },
                        onDelete: () async {
                          await PegawaiService.deletePegawai(p.id!);
                          refresh();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Data Pegawai",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
