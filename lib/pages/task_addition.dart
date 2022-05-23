
import 'package:alarm_app/model_class/mode_class.dart';
import 'package:alarm_app/services/task_services.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {


  bool _validateTitle = false;
  bool _validateTask = false;


  var _taskServices = TaskServices();

  var _task = TextEditingController();
  var _title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Task', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _title,
                keyboardType: TextInputType.text,
                decoration:  InputDecoration(
                  errorText: _validateTitle ? 'Title field cannot be empty' : null ,
                  border: OutlineInputBorder(),
                  labelText: 'Task Title'
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _task,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    errorText: _validateTask ? 'Task field cannot be empty' : null ,
                    border: OutlineInputBorder(),
                    labelText: 'Task Description'
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  TextButton(
                      onPressed: () async{
                        setState(() {
                          _title.text.isEmpty ? _validateTitle = true: _validateTitle = false;
                          _task.text.isEmpty ? _validateTask = true : _validateTask = false;
                        });

                        if (_validateTitle == false && _validateTask == false){
                          var _taskDescription = TaskDescription();
                          _taskDescription.taskTitle = _title.text;
                          _taskDescription.taskDescription = _task.text;
                          var result = await _taskServices.SaveUser(_taskDescription);
                          print(result);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Add Task', style: TextStyle(backgroundColor: Colors.green, color: Colors.white, fontSize: 20),),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () {
                        _task.text = '';
                        _title.text = '';
                      },
                      child: const Text('Clear Task', style: TextStyle(backgroundColor: Colors.redAccent, color: Colors.white, fontSize: 20),)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
