import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControlScreen extends StatelessWidget {
  final String name;
  final String endpoint;

  const ControlScreen({Key? key,required this.name,required this.endpoint}) : super(key: key);

   action(String actionType) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': actionType,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create action.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.4,
        decoration: BoxDecoration(
          color: Color(0xfff607d8b),
          borderRadius: BorderRadius.all(Radius.circular(150))
        ),
        padding: EdgeInsets.only(top: 20),
        margin: EdgeInsets.only(left: 10,right: 10,top: MediaQuery.of(context).size.height*0.19),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xfff607d8b),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
              ),
              child: const Icon(
                Icons.arrow_upward,
                size: 50,
              ),
              onPressed: () {
                action("up");
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: Color(0xfff607d8b),
                      padding: const EdgeInsets.all(20)
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 50,
                  ),
                  onPressed: () {
                    action("left");
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: Color(0xfff607d8b),
                      padding: const EdgeInsets.all(20)
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 50,
                  ),
                  onPressed: () {
                    action("right");
                  },
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  primary: Color(0xfff607d8b),
                  padding: const EdgeInsets.all(20)
              ),
              child: const Icon(
                Icons.arrow_downward,
                size: 50,
              ),
              onPressed: () {
                action("down");
              },
            ),
          ],
        ),
      ),
    );
  }
}
