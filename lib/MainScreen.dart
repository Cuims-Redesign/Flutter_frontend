import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this.split(" ").map((str) => str.inCaps).join(" ");
}

class MainScreen extends StatelessWidget {
  final List attend;
  final String image;
  const MainScreen({Key key, this.attend, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return new WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    child: Center(
                      child: Container(
                        color: Color(0xAA222222),
                        height: height * 0.11,
                        width: width - 30,
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
                                  nameText(),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 1,
                              height: height * 0.07,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            AvatarN(
                              imagebyte: image,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xAA222222),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: width - 30,
                  height: height * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        child: Text('Attendence',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'NotoSans',
                            )),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                              itemCount: attend.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                                  child: ListTile(
                                      isThreeLine: false,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      title: Text('${attend[index]['Title']}'),
                                      subtitle: Text('${attend[index]['Total_Perc']}'),
                                      tileColor: Color(0xFF777777),
                                      onTap: () {
                                        var a = attend[index]
                                            .toString()
                                            .replaceAll(
                                                new RegExp(
                                                  r'[{}]',
                                                ),
                                                '')
                                            .split(',');
                                        print(a);
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  title: Text('${attend[index]['Title']}'),
                                                  content: Container(
                                                    height: 300.0, // Change as per your requirement
                                                    width: 300.0, // Change as per your requirement
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: a.length,
                                                      itemBuilder:
                                                          (BuildContext context, int index) {
                                                        return ListTile(
                                                          title: Text(a[index]),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ));
                                      }),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text nameText() {
    return Text(
      attend[0]['name'].toString().toLowerCase().capitalizeFirstofEach.replaceAll(' ', '\n'),
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 25,
        color: Colors.white,
        fontFamily: 'NotoSans',
      ),
    );
  }
}

class AvatarN extends StatelessWidget {
  final String imagebyte;
  const AvatarN({Key key, this.imagebyte}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(imagebyte);
    return CircleAvatar(
      radius: 40,
      backgroundImage: MemoryImage(bytes),
    );
  }
}
