import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherRepo {
  String link =
      "https://api.openweathermap.org/data/2.5/weather?q=CITY_NAME&appid=APP_ID&units=metric";

  Future<Weather> getWeather(String cityName) async {
    final result = await http.Client()
        .get(Uri.parse(link.replaceAll("CITY_NAME", cityName)));

    if (result.statusCode != 200) {
      throw Exception();
    }

    return getMainWeatherFromWeatherJson(result.body);
  }

  Weather getMainWeatherFromWeatherJson(String jsonResponse) {
    final weatherJson = json.decode(jsonResponse);
    return Weather.fromJson(weatherJson["main"]);
  }
}
