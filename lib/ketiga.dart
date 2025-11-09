import 'package:flutter/material.dart';

class Ketiga extends StatefulWidget {
  const Ketiga({super.key});

  @override
  State<Ketiga> createState() => _KetigaState();
}

class _KetigaState extends State<Ketiga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Header Text
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.topCenter,
              child: Text(
                "Output dari pabrik otomotif",
                style: TextStyle(fontSize: 24),
              ),
            ),

            // Image
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset('assets/images/cybertruck.jpeg'),
            ),

            // Additional info cards
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(Icons.engineering, color: Colors.red),
                            SizedBox(height: 8),
                            Text(
                              'Quality',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Terjamin'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(Icons.speed, color: Colors.red),
                            SizedBox(height: 8),
                            Text(
                              'Performance',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Optimal'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Back Button - DIUBAH dari IconButton ke ElevatedButton
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // DIUBAH: Kembali ke halaman sebelumnya
                },
                child: Text(
                  'Kembali',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}