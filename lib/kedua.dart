import 'package:flutter/material.dart';

class Kedua extends StatefulWidget {
  const Kedua({super.key});

  @override
  State<Kedua> createState() => _KeduaState();
}

class _KeduaState extends State<Kedua> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Opsional: tambahkan AppBar untuk konsistensi
        title: Text('Proses Pabrik'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16), // Tambahkan padding umum
        child: Column(
          children: <Widget>[
            // Header Text
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Text(
                "Pemrosesan Bahan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Image dengan handling error yang lebih baik
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                'assets/images/Process.jpeg',
                width: double.infinity, // Lebar penuh
                height: 250, // Tinggi tetap
                fit: BoxFit.cover, // Agar gambar proporsional
                errorBuilder: (context, error, stackTrace) {
                  return Container( // Fallback jika gambar tidak ditemukan
                    height: 250,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),

            // Description (opsional)
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Proses manufacturing di pabrik otomotif modern "
                    "menggunakan teknologi terkini untuk menghasilkan "
                    "kendaraan yang berkualitas tinggi.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),

            // Back Button
            Container(
              padding: EdgeInsets.only(top: 30),
              width: double.infinity, // Button lebar penuh
              child: FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
                },
                child: Text(
                  "Kembali ke Beranda",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}