import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/weather_model.dart';

class CityWeatherPageWidget extends StatelessWidget {
  const CityWeatherPageWidget({
    Key key,
    @required this.cityWeather,
    @required this.weatherBloc,
  }) : super(key: key);

  final Weather cityWeather;
  final WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    return CityWeatherWidget(
      cityWeather: cityWeather,
      weatherBloc: weatherBloc,
    );
  }
}

class CityWeatherWidget extends StatelessWidget {
  const CityWeatherWidget({
    Key key,
    @required this.cityWeather,
    @required this.weatherBloc,
  }) : super(key: key);

  final Weather cityWeather;
  final WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${cityWeather.temp}°",
          style: TextStyle(
            fontSize: 64,
          ),
        ),
        SizedBox(height: 4),
        Text("Feels Like ${cityWeather.feelsLike}°"),
        SizedBox(height: 24),
        Text(
            "${cityWeather.maxTemp.toInt().toString()}° / ${cityWeather.minTemp.toInt().toString()}°"),
        SizedBox(height: 100),
        ElevatedButton(
          onPressed: () {
            weatherBloc.add(ResetCityEvent());
          },
          child: Text("Check Another City's Weather"),
        )
      ],
    );
  }
}
