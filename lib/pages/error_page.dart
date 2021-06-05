import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class ErrorPageWidget extends StatelessWidget {
  const ErrorPageWidget({
    Key key,
    @required this.weatherBloc,
    @required this.cityName,
  }) : super(key: key);

  final WeatherBloc weatherBloc;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          "assets/city-not-found.svg",
          semanticsLabel: 'City Not Found',
          width: 450,
          height: 450,
        ),
      ),
      Text(
        "City '${this.cityName}' Doesn't Exist!",
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      SizedBox(
        height: 24,
      ),
      ElevatedButton(
        onPressed: () {
          weatherBloc.add(ResetCityEvent());
        },
        child: Text("Search For Another City"),
      )
    ]);
  }
}
