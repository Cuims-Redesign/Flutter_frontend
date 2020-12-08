import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'MainScreen.dart';
import 'function.dart';

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
  List data, attend;

  @override
  void initState() {
    super.initState();
    getdata(widget.user, widget.pass, context);
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
                Center(child: Status()),
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class Status extends StatefulWidget {
  final String user;
  final String pass;

  const Status({
    Key key,
    this.user,
    this.pass,
  }) : super(key: key);
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  List<String> _currentstatus;
  void initState() {
    _currentstatus = formlist('Logging In');
    super.initState();
    updater();
  }

  updater() async {
    var data = await getdata(widget.user, widget.pass, context);
    setState(() {
      _currentstatus = formlist('Getting Attendence');
    });

    var attend = await getAttendence(data);
    setState(() {
      _currentstatus = formlist('Getting Picture');
    });

    var image = await getimage(data);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                  attend: attend,
                  image: image,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimatedTextKit(
      text: _currentstatus,
      textStyle: TextStyle(fontSize: 18.0, color: Colors.white70, fontFamily: 'NotoSans'),
    );
  }
}
