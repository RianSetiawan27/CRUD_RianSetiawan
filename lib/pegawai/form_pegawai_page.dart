import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/pegawai.dart';
import '../services/pegawai_service.dart';

class FormPegawaiPage extends StatefulWidget {
  final Pegawai? pegawai;

  const FormPegawaiPage({super.key, this.pegawai});

  @override
  State<FormPegawaiPage> createState() => _FormPegawaiPageState();
}

class _FormPegawaiPageState extends State<FormPegawaiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final nipController = TextEditingController();
  final namaController = TextEditingController();
  final jabatanController = TextEditingController();
  final departemenController = TextEditingController();
  final noHpController = TextEditingController();
  final emailController = TextEditingController();
  final alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.pegawai != null) {
      nipController.text = widget.pegawai!.nip;
      namaController.text = widget.pegawai!.nama;
      jabatanController.text = widget.pegawai!.jabatan;
      departemenController.text = widget.pegawai!.departemen;
      noHpController.text = widget.pegawai!.noHp;
      emailController.text = widget.pegawai!.email;
      alamatController.text = widget.pegawai!.alamat;
    }
  }

  @override
  void dispose() {
    nipController.dispose();
    namaController.dispose();
    jabatanController.dispose();
    departemenController.dispose();
    noHpController.dispose();
    emailController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final pegawai = Pegawai(
        nip: nipController.text.trim(),
        nama: namaController.text.trim(),
        jabatan: jabatanController.text.trim(),
        departemen: departemenController.text.trim(),
        noHp: noHpController.text.trim(),
        email: emailController.text.trim(),
        alamat: alamatController.text.trim(),
      );

      if (widget.pegawai != null) {
        await PegawaiService.updatePegawai(widget.pegawai!.id!, pegawai);
      } else {
        await PegawaiService.addPegawai(pegawai);
      }

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Data berhasil disimpan')));
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ================= UI COMPONENT =================
  Widget _glassInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
        color: Colors.white.withOpacity(0.06),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: controller,
                  validator: validator,
                  keyboardType: keyboardType,
                  maxLines: maxLines,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.pegawai != null;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // ===== Background Gradient Blob =====
          Positioned(top: -120, left: -80, child: _blob(260, Colors.purple)),
          Positioned(top: -80, right: -80, child: _blob(240, Colors.blue)),
          Positioned(bottom: -140, left: -100, child: _blob(300, Colors.pink)),

          // ===== Main Card =====
          SafeArea(
            child: Center(
              child: Container(
                width: 420,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    // ===== Header =====
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.12),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            isEdit ? "Edit Pegawai" : "Tambah Pegawai",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ===== Form =====
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            _glassInput(
                              label: "NIP",
                              hint: "Masukkan NIP",
                              controller: nipController,
                              validator: (v) => v == null || v.isEmpty
                                  ? "NIP wajib diisi"
                                  : null,
                            ),
                            _glassInput(
                              label: "Nama",
                              hint: "Masukkan Nama Lengkap",
                              controller: namaController,
                              validator: (v) => v == null || v.isEmpty
                                  ? "Nama wajib diisi"
                                  : null,
                            ),
                            _glassInput(
                              label: "Jabatan",
                              hint: "Masukkan Jabatan",
                              controller: jabatanController,
                            ),
                            _glassInput(
                              label: "Departemen",
                              hint: "Masukkan Departemen",
                              controller: departemenController,
                            ),
                            _glassInput(
                              label: "No HP",
                              hint: "08xxxxxxxxxx",
                              controller: noHpController,
                              keyboardType: TextInputType.phone,
                            ),
                            _glassInput(
                              label: "Email",
                              hint: "contoh@email.com",
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.isEmpty)
                                  return "Email wajib diisi";
                                if (!v.contains('@'))
                                  return "Email tidak valid";
                                return null;
                              },
                            ),
                            _glassInput(
                              label: "Alamat",
                              hint: "Masukkan Alamat Lengkap",
                              controller: alamatController,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 24),

                            // ===== Button =====
                            SizedBox(
                              height: 54,
                              child: InkWell(
                                onTap: _isLoading ? null : _submit,
                                borderRadius: BorderRadius.circular(16),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFA855F7),
                                        Color(0xFFEC4899),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purple.withOpacity(0.4),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: _isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            isEdit ? "UPDATE" : "SIMPAN",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.35),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: const SizedBox(),
      ),
    );
  }
}
