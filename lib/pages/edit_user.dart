// import 'package:alarm_app/model_class/mode_class.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ViewUser extends StatefulWidget {
//   final TaskDescription taskDescription;
//
//   const ViewUser({Key? key, required this.taskDescription}) : super(key: key);
//
//   @override
//   State<ViewUser> createState() => _ViewUserState();
// }
//
// class _ViewUserState extends State<ViewUser> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           title: const Text("Edit Task", style: TextStyle(color: Colors.black),),
//         ),
//         body: Container(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Task Details",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.blueGrey,
//                     fontSize: 20),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   const Text('Task Title',
//                       style: TextStyle(
//                           color: Colors.teal,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600)),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 30),
//                     child: Text(widget.taskDescription.taskTitle ?? '', style: TextStyle(fontSize: 16)),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Description',
//                       style: TextStyle(
//                           color: Colors.teal,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600)),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Text(widget.taskDescription.taskDescription ?? '', style: const TextStyle(fontSize: 16)),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }

import 'package:alarm_app/model_class/mode_class.dart';
import 'package:flutter/material.dart';

import '../services/task_services.dart';

class EditUser extends StatefulWidget {


  final TaskDescription taskDescription;


  const EditUser({Key? key,required this.taskDescription}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var _task = TextEditingController();
  var _title = TextEditingController();


  bool _validateTitle = false;
  bool _validateTask = false;


  var _taskServices = TaskServices();

  @override
  void initState() {
    setState(() {
      _task.text=widget.taskDescription.taskDescription??'';
      _title.text=widget.taskDescription.taskTitle??'';
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Edit Task Page"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Task',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _title,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                    _validateTitle ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _task,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Contact',
                    labelText: 'Contact',
                    errorText: _validateTask
                        ? 'Contact Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _title.text.isEmpty
                              ? _validateTitle = true
                              : _validateTitle = false;
                          _task.text.isEmpty
                              ? _validateTask = true
                              : _validateTask = false;

                        });
                        if (_validateTitle == false &&
                            _validateTask == false) {
                          // print("Good Data Can Save");
                          var _user = TaskDescription();
                          _user.id=widget.taskDescription.id;
                          _user.taskTitle = _title.text;
                          _user.taskDescription = _task.text;
                          var result=await _taskServices.UpdateUser(_user);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _title.text = '';
                        _task.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}