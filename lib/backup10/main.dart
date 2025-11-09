import 'package:flutter/material.dart';
import 'screens/AddUser.dart';
import 'screens/EditUser.dart';
import 'screens/ViewUser.dart';
import 'services/UserService.dart';
import 'model/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _userList = [];
  final _userService = UserService();
  bool _isLoading = false;

  Future<void> getAllUserDetails() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var users = await _userService.readAllUsers();
      List<User> tempList = [];

      for (var user in users) {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.telepon = user['telepon'];
        userModel.deskripsi = user['deskripsi'];
        tempList.add(userModel);
      }

      setState(() {
        _userList = tempList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading users: $e');
      _showSuccessSnackBar('Error loading users: ${e.toString()}');
    }
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    var result = await
                    _userService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      _showSuccessSnackBar('User Detail Deleted Success');
                      }
                      },
                  child: const Text('Delete')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _userList.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No users yet',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap + button to add a user',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Viewusers(
                            user: _userList[index],
                          )));
                },
                leading: const Icon(Icons.person),
                title: Text(_userList[index].name ?? ''),
                subtitle: Text(_userList[index].telepon ??
                    ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Edituser(
                                        user:
                                        _userList[index],
                                      ))).then((data) {
                            if (data != null) {
                              getAllUserDetails();
                              _showSuccessSnackBar(
                                  'User Detail Updated Success');
                              }
                              });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context,
                              _userList[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const
              Adduser()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar('User Detail Added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}