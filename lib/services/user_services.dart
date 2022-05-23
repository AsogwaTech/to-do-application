

//import '../repository/repository.dart';

import 'package:alarm_app/model_class/mode_class.dart';
import 'package:alarm_app/repository/repository.dart';

class UserServices{
  late Repository _repository;
  UserServices(){
    _repository = Repository();
  }

  SaveUser(UserData userData) async{
    return await _repository.insertData('users', userData.userDataMap());
  }
  //Read All Users
  readAllUsers() async{
    return await _repository.readData('users');
  }
  //Edit User
  UpdateUser(UserData userData) async{
    return await _repository.updateData('users', userData.userDataMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }
}