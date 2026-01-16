import 'package:flutter/material.dart';
import 'pegawai/pegawai_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pegawai App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const PegawaiPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
