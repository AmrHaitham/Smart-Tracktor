import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class ControlScreen extends StatelessWidget {
  final String name;
  final String endpoint;
  final String image;

  ControlScreen({Key? key,required this.name,required this.endpoint,required this.image}) : super(key: key);

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
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height:MediaQuery.of(context).size.height*0.3,
              child: WebView(
                zoomEnabled: true,
                allowsInlineMediaPlayback: true,
                initialUrl: 'https://www.google.com/maps/place/Faculty+of+Agricultural+Engineering,+Al-Azhar+University+Cairo+Branch/@30.0541341,31.3207675,15z/data=!4m5!3m4!1s0x0:0x10c57af2b0bec9a5!8m2!3d30.0541341!4d31.3207675',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) {
                  print('web is loading (progress : $progress%)');
                },
                javascriptChannels: <JavascriptChannel>{
                  _toasterJavascriptChannel(context),
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
                backgroundColor: const Color(0x00000000),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.55,
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.3,
                    decoration: BoxDecoration(
                      color: Color(0xfff607d8b),
                      borderRadius: BorderRadius.all(Radius.circular(150)),
                      image: DecorationImage(
                        image:const AssetImage("assets/pattern.jpg"),
                        colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.05), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: EdgeInsets.only(top: 15),
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xfff607d8b),
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
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
                                  padding: const EdgeInsets.all(10)
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
                                  padding: const EdgeInsets.all(10)
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
                              padding: const EdgeInsets.all(10)
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
                  Container(
                      margin:const EdgeInsets.only(top: 10),
                      width:200,
                      height:200,
                      child: Image.asset(image)
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
