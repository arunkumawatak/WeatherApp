import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/model.dart';

class weatherServices {
  fetchWeather() async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=22.962267&lon=76.050797&appid=03f7b3fa87af10eb50decd899071c999"));
    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        return WeatherData.fromJson(json);
      } else {
        throw Exception("Failed to load weather data  ");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
