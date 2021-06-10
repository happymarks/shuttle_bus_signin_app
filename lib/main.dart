import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '交通車簽到',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: '交通車簽到'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _busNo = "";
  String _site = "上班";//Q1. site
  int itemValue = 1;

  var _busNocontroller = TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _FinishBtnClickEvent(){
    setState(() {
      print("click Finish button ... ");
      //reset
      _busNo = "";
      _site = "01";
      _busNocontroller.clear();
    });
  }

  void _ImageBtnClickEvent(){
    setState(() {
      print("click Image button!");
      _sendRequest();
    });
  }

  var url = "https://api.surveymonkey.com/v3/collectors/405733373/responses";
  var token = "bearer 3AtBU1BWplHgn9j081RWbb3Gmb5gBSPGOgl2FyHAC9zvfsv7wvg8w8B98rQyDYj2IBEcJjJy9d.FmS4Zx1VFsq0JKJeECMWe2rmSaKDOBPCsD9SdjTiPRld6IR9trzR6";
  var bodyTemp = '{\"pages\": [{\"id\": \"168598257\",\"questions\": [{\"id\": \"666420957\",\"answers\": [{\"text\": \"#BUSNO\"}]},{\"id\": \"666421140\",\"answers\": [{\"text\": \"#WORK\"}]},{\"id\": \"666421041\",\"answers\": [{\"text\": \"#EMPLID\"}]}]}]}';
  void _sendRequest() {
    print("start _sendRequest() ... ");
    print("_busNo: " + _busNo);
    print("_site: " + _site);
    var _client = http.Client();
    //set headers
    Map<String, String> headersMap = new Map();
    headersMap["Authorization"] = token;
    headersMap["Content-Type"] = "application/json";
    //set body
    Map<String, String> question1 = new Map();
    question1["id"] = "666420957";

    Map<String, String> bodyParams = new Map();
    print("finish request data ...");

    var bodyStr = bodyTemp.replaceAll("#BUSNO", _busNo).replaceAll("#SITE", _site).replaceAll("#EMPLID", "096772");

    //post
    _client
        .post(url, headers: headersMap, body: bodyStr)
        .then((http.Response response) {

          print(response.statusCode);

    }).catchError((onError){
      print(" in Error : " + onError.toString());
    });

  }

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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, 32, 24, 32),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "區域:",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                  value: "01",
                  groupValue: this._site,
                  onChanged: (value) {
                    setState(() {
                      this._site = value.toString();
                      print(this._site);
                    });
                  },
                ),
                Text("竹科"),
                Radio(
                  value: "02",
                  groupValue: this._site,
                  onChanged: (value) {
                    setState(() {
                      this._site = value.toString();
                      print(this._site);
                    });
                  },
                ),
                Text("中科"),
                Radio(
                  value: "03",
                  groupValue: this._site,
                  onChanged: (value) {
                    setState(() {
                      this._site = value.toString();
                      print(this._site);
                    });
                  },
                ),
                Text("南科"),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "交通車公司:",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: 170,
                  child: TextField(
                    controller: _busNocontroller,
                    autofocus: true,
                    decoration: InputDecoration(
                      // labelText: "車號: ",
                      hintText: "ABC-123",
                      hintStyle: TextStyle(color: Colors.black26),
                      prefixIcon: Icon(Icons.directions_bus),
                      suffixIcon: IconButton(
                        onPressed: () => _busNocontroller.clear(),
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    maxLength: 7,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters : [
                      WhitelistingTextInputFormatter(RegExp("[A-Za-z]|[-]|[0-9]")),
                    ],
                    onSubmitted: (val){
                      print("busNo:::： " + val);
                      _busNo = val;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "上班/下班:",
                style: TextStyle(color: Colors.black54),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "人員簽到:",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      width: 170,
                      child: DropdownButton(
                        hint: Text("請選擇"),
                        items: [
                          DropdownMenuItem(
                            child: Text("Item 1"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Item 2"),
                            value: 2,
                          )],
                        value: itemValue,
                        elevation: 1,
                        // icon: Icon(
                        //   Icons.airplay,
                        //   size: 20,
                        // ),
                        onChanged: (value) {
                          setState(() {
                             print(value.toString());
                          });
                        },
                      )
                  ),
                ]
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: () {_ImageBtnClickEvent();},
            //       child: Container(
            //         padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
            //         child: Image.asset('assets/QRCode.png', width: 200.0, height: 200.0),
            //       ),
            //     ),
            //
            //   ],
            // ),
            // Center(
            //   child: new MaterialButton(
            //     child: Text("完成簽到"),
            //     color: Colors.lightGreen,
            //     textColor: Colors.white,
            //     minWidth: 200,
            //     onPressed: _FinishBtnClickEvent,
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(90, 12, 90, 7),
        child: new MaterialButton(
          child: Text("完成簽到"),
          color: Colors.lightGreen,
          textColor: Colors.white,
          minWidth: 100,
          onPressed: _FinishBtnClickEvent,
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
