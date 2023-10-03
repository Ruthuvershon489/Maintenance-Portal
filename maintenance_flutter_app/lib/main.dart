// ignore_for_file: sort_child_properties_last, avoid_print
// flutter run -d edge --web-port 4200

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:xml/xml.dart' as xml;
import 'package:maintenance_flutter_app/dashboardpage.dart';
import 'package:maintenance_flutter_app/notificationpage.dart';
import 'package:maintenance_flutter_app/workorderpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = "Maintenance Portal";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          backgroundColor: Color.fromARGB(255, 0, 102, 120),
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

late String body;
var message;
var code;

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // padding: const EdgeInsets.all(10),
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/image2.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(0, 150, 0, 0)),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Welcome Back :)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 21, 0, 255),
                    fontSize: 30),
              )),
          Container(
              width: 300,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: TextField(
                textAlign: TextAlign.center,
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: "Username",
                    border: OutlineInputBorder(),
                    labelText: 'Username'),
              )),
          Container(
              width: 300,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: passwordController,
                decoration: const InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                    labelText: 'Password'),
              )),
          Container(
              height: 40,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  print(nameController.text);
                  print(passwordController.text);

                  message = await getdata();

                  print("Message ========>");
                  print(message);
                  print(message.runtimeType);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DashboardPage()));

                  // if (message == "1") {
                  //   print("Status: Success");
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => DashboardPage()));
                  // } else {
                  //   print("Failed");
                  // }
                },
              )),
          Row(
            children: <Widget>[
              const Text('Does not have account?'),
              TextButton(
                child: const Text(
                  'Signup',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  //signup screen
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    ));
  }

  getdata() async {
    print("Hi there");
    const url = "http://localhost:3090/login";
    final uri = Uri.parse(url);

    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'mode': 'no-cors'
        },
        body: jsonEncode(<String, String>{
          "uname": nameController.text,
          "password": passwordController.text
        }));

    body = response.body;
    print("body=====>");
    print(body);
    print(response.body.runtimeType);

    var code = body[1];
    print("code======>");
    print(code);
    print(code.runtimeType);

    return code;
  }
}
