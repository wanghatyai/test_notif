import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomizedNotification extends StatefulWidget {
  @override
  _CustomizedNotificationState createState() => _CustomizedNotificationState();
}

class _CustomizedNotificationState extends State<CustomizedNotification> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTime();
  }

  String startTime = "";
  String endTime = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Text("Notif Start", style: TextStyle(fontSize: 30)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(startTime, style: TextStyle(fontSize: 30)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Text("Notif Stop", style: TextStyle(fontSize: 30)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(endTime, style: TextStyle(fontSize: 30)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: RaisedButton(
                          onPressed: (){

                          },
                          child: Text("OK"),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  getTime(){
    SharedPreferences.getInstance().then((value) {
      var a = value.getString('startTime');
      var b = value.getString('endTime');
      if(a != null && b != null){
        setState(() {
          startTime = DateFormat('jm').format(DateTime.parse(a));
          endTime = DateFormat('jm').format(DateTime.parse(b));
        });
      }
    });
  }
}
