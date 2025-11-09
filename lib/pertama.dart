import 'package:flutter/material.dart';

class Pertama extends StatefulWidget {
  const Pertama({super.key});

  @override
  State<Pertama> createState() => _PertamaState();
}

class _PertamaState extends State<Pertama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Opsional: tambahkan AppBar
        title: Text('Bahan Mentah'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16), // Padding konsisten
        child: Column(
          children: <Widget>[
            // Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Text(
                "Bahan Mentah",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            // Image
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                'assets/images/Lithium.jpeg',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            // Back Button
            Container(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
                },
                child: Text(
                  'Kembali',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}