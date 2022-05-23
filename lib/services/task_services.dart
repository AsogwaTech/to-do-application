
import 'package:alarm_app/model_class/mode_class.dart';
import 'package:alarm_app/repository/repository.dart';

class TaskServices{
  late Repository _repository;

  TaskServices(){
    _repository = Repository();
  }
  SaveUser(TaskDescription taskDescription) async{
    return await _repository.insertData('task_descriptions', taskDescription.taskDescriptionMap());
  }
  //Read All Users
  readAllUsers() async{
    return await _repository.readData('task_descriptions');
  }
  //Edit User
  UpdateUser(TaskDescription taskDescription) async{
    return await _repository.updateData('task_descriptions', taskDescription.taskDescriptionMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('task_descriptions', userId);
  }
}