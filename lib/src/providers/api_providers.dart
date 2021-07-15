import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test_case/src/models/getDataModel.dart';

class ApiProviders {
  String url = "https://swapi.dev/api/people/";

  Future getData() async {
    Uri uri = Uri.parse('$url');
    var body = jsonEncode({});
    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 11));
      if (res.statusCode == 200) {
        // print(json.decode(res.body)['results']);
        return GetDataModel.fromJson(json.decode(res.body));
      } else if (res.statusCode == 404) {
        return GetDataModel.fromJson(json.decode(res.body));
      } else {
        throw Exception('Failure response');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }
}
