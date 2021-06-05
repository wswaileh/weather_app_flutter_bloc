import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class LinearGradientBackgroundWidget extends StatelessWidget {
  const LinearGradientBackgroundWidget(
      {Key key, @required this.weatherBloc, @required this.child})
      : super(key: key);

  final Widget child;
  final WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Colors.white,
            ]),
      ),
      child: child,
    );
  }
}
