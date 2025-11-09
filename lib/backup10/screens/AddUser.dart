import 'package:flutter/material.dart';
import '../model/User.dart';
import '../services/UserService.dart';
class Adduser extends StatefulWidget {
  const Adduser({super.key});
  @override
  State<Adduser> createState() => _AdduserState();
}
class _AdduserState extends State<Adduser> {
  var _userNameController = TextEditingController();
  var _userTeleponController = TextEditingController();
  var _userDeskripsiController = TextEditingController();
  bool _validateName = false;
  bool _validateTelepon = false;
  bool _validateDeskripsi = false;
  var _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD pada SQLite"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Masukan User'),
              SizedBox(
                height: 15,
              ),
              TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Masukan Nama',
                      labelText: 'Nama',
                      errorText: _validateName ? 'Nama tidak boleh Skosong' : null,
                  )),
              SizedBox(
                height: 15,
              ),
              TextField(
                  controller: _userTeleponController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukan Nomor Telepon',
                    labelText: 'Telepon',
                    errorText: _validateTelepon
                        ? 'Nomor Telepon tidak boleh kosong'
                        : null,
                  )),
              SizedBox(
                height: 15,
              ),
              TextField(
                  controller: _userDeskripsiController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukan Deskripsi',
                    labelText: 'Deskripsi',
                    errorText: _validateDeskripsi
                        ? 'Deskripsi tidak boleh kosong'
                        : null,
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;

                          _userTeleponController.text.isEmpty
                              ? _validateTelepon = true
                              : _validateTelepon = false;

                          _userDeskripsiController.text.isEmpty
                              ? _validateDeskripsi = true
                              : _validateDeskripsi = false;
                        });
                        if (_validateName == false &&
                            _validateTelepon == false &&
                            _validateDeskripsi == false) {
                          var _user = User();
                          _user.name = _userNameController.text;
                          _user.telepon = _userTeleponController.text;
                          _user.deskripsi =
                              _userDeskripsiController.text;
                          var result = await
                          _userService.SaveUser(_user);
                          Navigator.pop(context, result);
                        }
                      },
                      child: Text("Simpan Detail"))
                ],
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () {
                    _userNameController.text = '';
                    _userTeleponController.text = '';
                    _userDeskripsiController.text = '';
                  },
                  child: Text("Clear")),
            ],
          ),
        ),
      ),
    );
  }
}