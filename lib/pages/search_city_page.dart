import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class SearchCityNamePage extends StatelessWidget {
  const SearchCityNamePage({
    Key key,
    @required TextEditingController controller,
    @required this.weatherBloc,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/search-city.svg",
              semanticsLabel: 'City Not Found',
              width: 450,
              height: 450,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "City Name",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) {
                if (_controller.text.isNotEmpty) {
                  weatherBloc.add(
                    LoadCityWeatherEvent(_controller.text),
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                weatherBloc.add(
                  LoadCityWeatherEvent(_controller.text),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Search",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
