import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_notif/sharedPrefs.dart';

import 'customizedNotification.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 7, 00);
    var endTime = DateTime(now.year, now.month, now.day, 22, 00);
    setStartTime(startTime);
    setEndTime(endTime);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return CustomizedNotification();
              }
            ));
          },
        ),
      ),
    );
  }
}