import 'package:dio/dio.dart';
import 'dart:convert';

getdata(user, pass, context) async {
  Dio dio = new Dio();
  List data;
  var response = await dio
      .get("https://cuims-api.herokuapp.com/login/?username=18bcs4002&password=Moksh@chd@21");
  data = response.data;
  dio.close(force: true);
  return data;
}

getAttendence(List data) async {
  Dio dio = new Dio();
  Response res =
      await dio.post("https://cuims-api.herokuapp.com/attendence", data: jsonEncode(data));
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Host'] = 'uims.cuchd.in';
  dio.options.headers['Content-Length'] = '68';
  Response res1 = await dio.post(
      "https://uims.cuchd.in/UIMS/frmStudentCourseWiseAttendanceSummary.aspx/GetReport",
      data: res.data);
  dio.close(force: true);
  return jsonDecode(res1.data['d']);
}

getimage(data) async {
  Dio dio = new Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  Response response =
      await dio.post('https://cuims-api.herokuapp.com/userpic', data: jsonEncode(data));
  dio.close(force: true);
  return response.data;
}

formlist(String name) {
  var arr = new List<String>(4);
  for (var i = 0; i < arr.length; i++) {
    arr[i] = name;
  }
  return arr;
}
