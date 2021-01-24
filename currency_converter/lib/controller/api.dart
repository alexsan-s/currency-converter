import 'dart:convert';

import 'package:dio/dio.dart';

Future<Map<String, dynamic>> getHttp() async {
  Map<String, dynamic> data = <String, dynamic>{};
  final Dio dio = Dio();
  Response<String> response;
  try {
    response =
        await dio.get<String>('https://economia.awesomeapi.com.br/json/all');
    if (response.statusCode == 200) {
      data = jsonDecode(response.data) as Map<String, dynamic>;
      return data;
    }
    return data;
  } catch (e) {
    return data;
  }
}
