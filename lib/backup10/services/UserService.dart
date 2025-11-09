import '../db_helper/repository.dart';
import '../model/User.dart';

class UserService {
  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

  SaveUser(User user) async {
    return await _repository.insertData('user', user.userMap());
  }

  readAllUsers() async {
    return await _repository.readData('user');
  }

  UpdateUser(User user) async {
    return await _repository.updateData('user', user.userMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('user', userId);
  }
}