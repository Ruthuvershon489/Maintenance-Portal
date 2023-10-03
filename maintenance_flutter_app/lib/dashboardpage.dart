import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maintenance_flutter_app/workorderpage.dart';
import 'package:maintenance_flutter_app/notificationpage.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  TextEditingController plantController1 = TextEditingController();
  TextEditingController groupController1 = TextEditingController();

  TextEditingController plantController2 = TextEditingController();
  TextEditingController groupController2 = TextEditingController();
  TextEditingController dateController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 245, 255, 105),

      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Color.fromARGB(255, 0, 102, 120),
      ),
      body: Stack(
        // child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 100, 20, 0)),
              Row(children: [
                Padding(padding: EdgeInsets.fromLTRB(440, 0, 0, 70)),
                Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.topLeft,
                    width: 200,
                    // padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: plantController1,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Planning Plant'),
                    )),
                Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.topLeft,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: groupController1,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Planner Group'),
                    )),
              ]),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 133, 70, 70),
                ),
                child: const Text('Workorder Details'),
                onPressed: () {
                  print(plantController1.text);
                  print(groupController1.text);
                  
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkorderPage(
                              plant: plantController1.text,
                              group: groupController1.text)));
                  // plantController1.clear();
                  // groupController1.clear();
                },
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(340, 0, 0, 70)),
                  Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.topLeft,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: plantController2,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Planning Plant'),
                      )),
                  Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.topLeft,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: groupController2,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Planner Group'),
                      )),
                  Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.topLeft,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: dateController2,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Date'),
                      )),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 133, 70, 70)),
                child: const Text('Noitification Details'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage(
                              plant: plantController2.text,
                              group: groupController2.text,
                              date: dateController2.text)));
                  // plantController2.clear();
                  // groupController2.clear();
                  // dateController2.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
