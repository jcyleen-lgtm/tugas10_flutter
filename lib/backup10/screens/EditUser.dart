import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/User.dart';
import '../services/UserService.dart';

class Edituser extends StatefulWidget {
  final User user;
  const Edituser({super.key, required this.user});
  @override
  State<Edituser> createState() => _EdituserState();
}

class _EdituserState extends State<Edituser> {
  var _userNameController = TextEditingController();
  var _userTeleponController = TextEditingController();
  var _userDeskripsiController = TextEditingController();
  bool _validateName = false;
  bool _validateTelepon = false;
  bool _validateDeskripsi = false;
  var _userService = UserService();

  void initState() {
    setState(() {
      _userNameController.text = widget.user.name ?? '';
      _userTeleponController.text = widget.user.telepon ?? '';
      _userDeskripsiController.text = widget.user.deskripsi ?? '';
    });
    super.initState();
  }

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
              Text('Edit data user'),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukan Nama',
                    labelText: 'Nama',
                    errorText: _validateName ? 'Nama tidak boleh kosong' : null,
                ),
              ),
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
                      ? 'Nomor Telepn tidak boleh kosong'
                      : null,
                ),
              ),
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
                ),
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
                          _user.id = widget.user.id;
                          _user.name = _userNameController.text;
                          _user.telepon = _userTeleponController.text;
                          _user.deskripsi =
                              _userDeskripsiController.text;
                          var result = await
                          _userService.UpdateUser(_user);
                          Navigator.pop(context, result);
                        }
                      },
                      child: Text("Perbaruhi Detail")),
                  SizedBox(
                    width: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        _userNameController.text = '';
                        _userTeleponController.text = '';
                        _userDeskripsiController.text = '';
                      },
                      child: Text('Hapus Detail'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}