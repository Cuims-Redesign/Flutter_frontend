import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.inCaps).join(" ");
}

class MainScreen extends StatelessWidget {
  final List data;
  const MainScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        // bottomNavigationBar: LowerBar(),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  child: ClipRRect(
                    child: Center(
                      child: Container(
                        color: Color(0xFF222228),
                        height: height * 0.15,
                        width: width * 0.95,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: width / 2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Moksh Chaudhary'
                                        .toString()
                                        .toLowerCase()
                                        .capitalizeFirstofEach,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontFamily: 'NotoSans',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 1,
                              height: height * 0.1,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            Avatar(
                              data: data,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.amber,
                  child: Textatt(
                    data: data,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LowerBar extends StatefulWidget {
  const LowerBar({
    Key key,
  }) : super(key: key);

  @override
  _LowerBarState createState() => _LowerBarState();
}

class _LowerBarState extends State<LowerBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      child: BottomNavigationBar(
        backgroundColor: Color(0xFF131313),
        selectedFontSize: 0,
        iconSize: 35,
        selectedIconTheme: const IconThemeData(color: Color(0x88EF0000)),
        unselectedIconTheme: IconThemeData(color: Colors.white30),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class Avatar extends StatefulWidget {
  final List data;
  Avatar({Key key, this.data}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  String _base64;
  @override
  void initState() {
    super.initState();
    getAttendence(widget.data);
    (() async {
      const headers = {'Content-Type': 'application/json'};
      http.Response response = await http.post(
        'https://cuims-api.herokuapp.com/userpic',
        body: jsonEncode(widget.data),
        headers: headers,
      );
      if (mounted) {
        setState(() {
          if (response.statusCode == 200) {
            _base64 = response.body;
          }
        });
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    if (_base64 == null) {
      return new CircleAvatar(
        radius: 40,
        backgroundColor: Color(0x00EF0000),
        child: CircularProgressIndicator(),
      );
    }

    Uint8List bytes = base64Decode(_base64);
    return CircleAvatar(
      radius: 45,
      backgroundImage: MemoryImage(bytes),
    );
  }
}

getAttendence(List data) async {
  Dio dio = new Dio();
  Response res = await dio.post("https://cuims-api.herokuapp.com/attendence",
      data: jsonEncode(data));
  print(res.data);

  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Host'] = 'uims.cuchd.in';
  dio.options.headers['Content-Length'] = '68';
  Response res1 = await dio.post(
      "https://uims.cuchd.in/UIMS/frmStudentCourseWiseAttendanceSummary.aspx/GetReport",
      data: res.data.toString());
  print(res1.data.toString());
  return res1.data.toString();
}

class Textatt extends StatefulWidget {
  final List data;
  Textatt({Key key, this.data}) : super(key: key);

  @override
  _TextattState createState() => _TextattState();
}

class _TextattState extends State<Textatt> {
  String texdata;
  String a;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (texdata == null) {
      return Text('waiting for text');
    } else {
      return Text(texdata,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ));
    }
  }
}
