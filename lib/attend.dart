import 'package:attendence/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';

class AttendScreen extends StatelessWidget {
  final String username;
  final String password;
  AttendScreen({this.username, this.password});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          child: Container(
        child: Load(
          user: username,
          pass: password,
        ),
      )),
    ));
  }
}

class Load extends StatefulWidget {
  final String user;
  final String pass;
  const Load({Key key, this.user, this.pass}) : super(key: key);
  @override
  _Load createState() => _Load();
}

class _Load extends State<Load> {
  List data;
  @override
  void initState() {
    super.initState();
    this.getdata(widget.user, widget.pass);
  }

  getdata(user, pass) async {
    print(user + pass);
    data = null;
    var url = 'https://cuims-api.herokuapp.com/login/?username=18bcs4028&password=Dikshit_7';
    var response = await http.get(url);
    var i = jsonDecode(response.body);
    setState(() {
      data = i;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen(
                    data: data,
                  )));
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Center(
          child: LoadingScreen(
        user: widget.user,
      ));
    }
    return Icon(Icons.panorama_fish_eye, color: Colors.white);
  }
}

class LoadingScreen extends StatelessWidget {
  final String user;
  LoadingScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Image(
              image: AssetImage('images/loader.gif'),
              // /image: NetworkImage('https://i.gifer.com/9u1B.gif'),
            )),
        SizedBox(
          child: Container(color: Colors.white),
          height: 1,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      text: 'Signing you in as',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'Notosans',
                        fontWeight: FontWeight.w100,
                      )),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      text: user.toUpperCase(),
                      style: TextStyle(
                        color: Color(0xFFEF0000),
                        fontSize: 50,
                        fontFamily: 'Notosans',
                        fontWeight: FontWeight.w100,
                      )),
                ),
                Expanded(child: Container()),
                Center(
                  child: FadeAnimatedTextKit(
                    text: [".", "..", "...", "....", "......"],
                    textStyle:
                        TextStyle(fontSize: 40.0, color: Colors.white70, fontFamily: 'NotoSans'),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
