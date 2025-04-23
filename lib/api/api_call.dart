import 'dart:convert';
import 'package:wynd/api/apikey.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=delhi,Ind&APPID=$apikey',
        ),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        print('api called');
        return data;
      } else {
        throw Exception(
          'Failed to load weather data. Status code: ${res.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
