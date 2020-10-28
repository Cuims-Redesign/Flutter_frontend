import 'package:attendence/attend.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(accentColor: Color(0x33EF0000)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
                    child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontFamily: 'Notosans',
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "to the ",
                        style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.white,
                            fontFamily: 'NotoSans'),
                      ),
                      TypewriterAnimatedTextKit(
                        text: [
                          "newer",
                          "better",
                          "faster",
                          "refined",
                        ],
                        textStyle: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'NotoSans',
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    'CUIMS',
                    style: TextStyle(
                      color: Color(0xFFEF0000),
                      fontSize: 55,
                      fontFamily: 'Notosans',
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TaskInput(title: 'Username', hide: false),
                    TaskInput(title: 'Password', hide: true),
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                  ],
                ),
              ),
            ),
            Container(
              child: LoginButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskInput extends StatelessWidget {
  final String title;
  final bool hide;
  TaskInput({this.title, this.hide});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
                cursorColor: Color(0xFFEF0000),
                cursorHeight: 30,
                obscureText: hide,
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 23, horizontal: 10),
                  labelStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  labelText: title,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFEF3333))),
                  fillColor: Color(0xFF222222),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          height: 55,
          child: RaisedButton(
            color: Color(0xDDEF0000),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: Icon(
              Icons.check,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () => {
              print('clicked'),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttendScreen(
                            username: '18bcs4002',
                            password: 'MPas',
                          )))
            },
          )),
    );
  }
}
