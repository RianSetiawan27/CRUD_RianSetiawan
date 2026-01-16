import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/pegawai.dart';

class PegawaiCard extends StatelessWidget {
  final Pegawai pegawai;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PegawaiCard({
    super.key,
    required this.pegawai,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _avatar(),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pegawai.nama,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${pegawai.jabatan} • ${pegawai.departemen}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                PopupMenuButton(
                  color: const Color(0xFF1E293B),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: onEdit,
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: onDelete,
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                  child: const Icon(Icons.more_vert, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar() {
    // Generate gradient colors based on name hash
    final colors = _getGradientColors();
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          pegawai.nama[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColors() {
    final colorPairs = [
      [Colors.purple, Colors.blue],
      [Colors.pink, Colors.redAccent],
      [Colors.teal, Colors.green],
      [Colors.orange, Colors.amber],
      [Colors.indigo, Colors.purpleAccent],
      [Colors.grey, Colors.blueGrey],
    ];
    final index = pegawai.nama.hashCode % colorPairs.length;
    return colorPairs[index];
  }
}
