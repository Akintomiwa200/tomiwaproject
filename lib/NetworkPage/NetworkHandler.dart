// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  Future<dynamic> post1Request(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
        return null; // Return null for unsuccessful responses
      }
    } catch (e) {
      print("Error Catch $e");
      return null; // Return null for exceptions
    }
  }
Future<dynamic> post2Request(String url, dynamic data) async {
  try {
    var response = await http.post(Uri.parse(url), body: jsonEncode(data));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      print("Error ${response.statusCode}");
      return null; // Return null for unsuccessful response
    }
  } catch (e) {
    print("Error Catch $e");
    return null; // Return null for caught errors
  }
}


  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));

//the file is d name value we use in php to store to db
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error ${myrequest.statusCode}");
    }
  }
}
