import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/pages/city_weather_page.dart';
import 'package:weather_app/pages/error_page.dart';
import 'package:weather_app/pages/search_city_page.dart';
import 'package:weather_app/repositories/weather_repo.dart';
import 'package:weather_app/widgets/linear_gradient_background.dart';

import 'bloc/weather_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFFd9effe,
          {
            50: Color(0xFFd9effe),
            100: Color(0xFFa8d6f7),
            200: Color(0xFF72bbee),
            300: Color(0xFF72bbee),
            400: Color(0xFF008ee1),
            500: Color(0xFF007ddb),
            600: Color(0xFF0070ce),
            700: Color(0xFF005fbd),
            800: Color(0xFF004fab),
            900: Color(0xFF00338d)
          },
        ),
      ),
      home: BlocProvider(
        create: (BuildContext context) {
          return WeatherBloc(WeatherRepo());
        },
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return MainWidget(weatherBloc: weatherBloc);
  }
}

class MainWidget extends StatefulWidget {
  final WeatherBloc weatherBloc;

  const MainWidget({
    Key key,
    @required this.weatherBloc,
  }) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState(this.weatherBloc);
}

class _MainWidgetState extends State<MainWidget> {
  _MainWidgetState(this.weatherBloc);

  TextEditingController _controller;

  final WeatherBloc weatherBloc;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(state.title),
            elevation: 0,
          ),
          body: Center(
            child: LinearGradientBackgroundWidget(
              weatherBloc: weatherBloc,
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is NoCitySelected) {
                    return SearchCityNamePage(
                      controller: _controller,
                      weatherBloc: weatherBloc,
                    );
                  } else if (state is LoadCityWeather) {
                    return Center(
                      child: SpinKitSquareCircle(
                        color: Theme.of(context).accentColor,
                        size: 100.0,
                      ),
                    );
                  } else if (state is LoadCityWeatherSuccess) {
                    return CityWeatherPageWidget(
                      weatherBloc: weatherBloc,
                      cityWeather: state.weather,
                    );
                  } else {
                    return ErrorPageWidget(
                      weatherBloc: weatherBloc,
                      cityName: _controller.text,
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
