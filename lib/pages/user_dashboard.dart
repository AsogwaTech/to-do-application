
import 'dart:io';

import 'package:alarm_app/model_class/mode_class.dart';
import 'package:alarm_app/pages/alarm_setting.dart';
import 'package:alarm_app/pages/task_addition.dart';
import 'package:alarm_app/services/picture_services.dart';
import 'package:alarm_app/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'edit_user.dart';
import 'package:path/path.dart' as path;

class Dashboard extends StatefulWidget {
  final String userNameOk;
  const Dashboard({Key? key, required this.userNameOk}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState(userNameOk);
}

class _DashboardState extends State<Dashboard> {
  final String userNameOk;
  _DashboardState(this.userNameOk);



  ImagePicker picker = ImagePicker();

  File? _imageFile;


  Future<void> _getCamera()async{
    XFile image = await picker.pickImage(source: ImageSource.camera) as XFile;
    // final appDir = await getApplicationDocumentsDirectory();
    // final fileName = path.basename(image.path);
    // String pathApp = appDir.path;
    // final newImage = await File (image.path).copy('$pathApp/$fileName');
    setState(() {
      _imageFile = File(image.path);
    });
    // final appDir = await getApplicationDocumentsDirectory();
    // final fileName = path.basename(image.path);
    // String pathApp = appDir.path;
    // final newImage = await File (image.path).copy('$pathApp/$fileName');
    Navigator.pop(context);
  }


  Future<void> _getGallery()async{
    XFile image = await picker.pickImage(source: ImageSource.gallery) as XFile;
    setState(() {
      _imageFile = File(image.path);
    });
    Navigator.pop(context);
  }

  void _camGallery(){
     showDialog(context: context, builder: (_){
       return AlertDialog(
         title: Text('Make Your Choice',style: TextStyle(backgroundColor: Colors.purple.withAlpha(30)),),
         content: Container(
           height: MediaQuery.of(context).size.height *0.2,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               InkWell(
                 onTap: _getCamera,
                 child: Text('Take a photo', style: TextStyle(fontSize: 20),),
               ),
               InkWell(
                 onTap: _getGallery,
                 child: Text('Import From gallery',style: TextStyle(fontSize: 20),),
               ),
             ],
           ),
         ),
       );
     });
  }

  var _taskServices = TaskServices();

  var _pictureServices = PictureServices();

  late List<TaskDescription> _taskDescriptionList = <TaskDescription>[];

  getAllUserDetails() async {
    var users = await _taskServices.readAllUsers();
    _taskDescriptionList = <TaskDescription>[];
    users.forEach((taskDescription) {
      setState(() {
        var userModel = TaskDescription();
        userModel.id = taskDescription['id'];
        userModel.taskTitle = taskDescription['taskTitle'];
        userModel.taskDescription = taskDescription['taskDescription'];
        _taskDescriptionList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

   _showSnackBar(String message){
    final snackBar = SnackBar(content:Text (message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: ()  async{
                    var result=await _taskServices.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      _showSnackBar(
                          'User Detail Deleted Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
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
       elevation: 0,
       centerTitle: true,
       backgroundColor: Colors.transparent,
       title: Text('${widget.userNameOk} Dashboard', style: TextStyle(color: Colors.black),),
     ),
     body: SingleChildScrollView(
       child: Container(
         margin: EdgeInsets.only(top: 20),
         child: Center(
           child:Column(
             children: [
               InkWell(
                 onTap: _camGallery,
                 child: CircleAvatar(
                   radius: 40,
                   backgroundImage:  _imageFile == null ? const AssetImage('assets/img.png') : Image.file(_imageFile!).image,
                 ),
               ),
               const SizedBox(height: 20,),
               const Text('LET MANAGE YOUR TASK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
               const SizedBox(height: 20,),
             ListView.builder(
               shrinkWrap: true,
               itemCount: _taskDescriptionList.length,
                 itemBuilder: (context,index){
                 return Card(
                  child: ListTile(
                    leading: IconButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                      icon: Icon(Icons.alarm),
                    ),
                    title: Text(_taskDescriptionList[index].taskTitle ?? ''),
                    subtitle: Text(_taskDescriptionList[index].taskDescription ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditUser(
                                        taskDescription: _taskDescriptionList[index],
                                      ))).then((data) {
                                if (data != null) {
                                  getAllUserDetails();
                                  _showSnackBar(
                                      'User Detail Updated Success');
                                }
                              });
                              ;
                            },
                            icon: Icon(Icons.edit, color: Colors.tealAccent,)
                        ),
                        IconButton(
                            onPressed: (){
                              _deleteFormDialog(context, _taskDescriptionList[index].id);
                            },
                            icon: Icon(Icons.delete, color: Colors.red,)
                        ),
                      ],
                    ),
                  ),
                 );
                 }
             ),
             ],
           ) ,
         ),
       ),
     ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTask()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSnackBar('User Detail Added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
