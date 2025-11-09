import 'package:flutter/material.dart';
import '../model/User.dart';

class Viewusers extends StatefulWidget {
  final User user;
  const Viewusers({super.key, required this.user});
  @override
  State<Viewusers> createState() => _ViewusersState();
}

class _ViewusersState extends State<Viewusers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD pada SQLite"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Detail"),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text('Nama'),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    widget.user.name ?? '',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text('No Telepon'),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(widget.user.telepon ?? ''),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Deskripsi'),
                SizedBox(
                  height: 20,
                ),
                Text(widget.user.deskripsi ?? ''),
              ],
            )
          ],
        ),
      ),
    );
  }
}