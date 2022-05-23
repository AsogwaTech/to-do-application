import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _hourController = TextEditingController();
  var _minuteController = TextEditingController();
  var _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _hourController,
                        decoration: InputDecoration(
                            labelText: 'Hour'
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _minuteController,
                        decoration: InputDecoration(
                            labelText: 'MINUTE'
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Alarm Title',
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: TextButton(
                onPressed: (){
                  int hour;
                  int minute;
                  String title;
                  title = _titleController.text;
                  hour = int.parse(_hourController.text);
                  minute = int.parse(_minuteController.text);
                  FlutterAlarmClock.createAlarm(hour, minute,title: title);// also contain the title of the alarm in which can be make to be entered by the usr
                  Navigator.pop(context);
                },
                child: Text('SET ALARM'),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                FlutterAlarmClock.showAlarms();
              },
              child: Text('Show alarms'),
            ),
            // Container(
            //   margin: EdgeInsets.all(25),
            //   child: TextButton(
            //     onPressed: (){
            //       int minute;
            //       minute = int.parse(_minuteController.text);
            //       FlutterAlarmClock.createTimer(minute * 60);
            //       showDialog(
            //           context: context,
            //           builder: (context){
            //             return AboutDialog(
            //               children: [
            //                 Center(
            //                   child: Text('Timer is set'),
            //                 )
            //               ],
            //             );
            //           }
            //       );
            //     },
            //     child: Text('create timer'),
            //   ),
            // ),
            // ElevatedButton(
            //     onPressed: (){
            //       FlutterAlarmClock.showTimers();
            //     },
            //     child: Text('show timers')
            // ),
          ],
        ),
      ),
    );
  }
}