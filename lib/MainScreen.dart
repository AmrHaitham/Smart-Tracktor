import 'package:flutter/material.dart';
import 'package:smart_tracktor/DefaultButton.dart';
import 'package:smart_tracktor/controlScreen.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data = [
    {
      "name":"Front wheel steering",
      "endPoint":"http://192.168.88.239:8080/move1",
      "image":"assets/1.png"
    },
    {
      "name":"Rear wheel steering",
      "endPoint":"http://http://192.168.88.239:8080/move2",
      "image":"assets/2.png"
    },
    {
      "name":"Four wheel steering",
      "endPoint":"http://http://192.168.88.239:8080/move3",
      "image":"assets/3.png"
    },
    {
      "name":"Crab steering",
      "endPoint":"http://http://192.168.88.239:8080/move4",
      "image":"assets/4.png"
    },
    {
      "name":"Side steering",
      "endPoint":"http://http://192.168.88.239:8080/move5",
      "image":"assets/5.png"
    },
    {
      "name":"Zero turn steering",
      "endPoint":"http://http://192.168.88.239:8080/move6",
      "image":"assets/6.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:const AssetImage("assets/pattern.jpg"),
              colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              for(int i = 0;i<6;i++)
                DefaultButton(
                  text: data[i]['name'],
                  press: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ControlScreen(name: data[i]['name']!, endpoint: data[i]['endPoint']!,image: data[i]['image']!,))
                    );
                  },
                ),
            ],
          ),
        )
    );
  }
}
