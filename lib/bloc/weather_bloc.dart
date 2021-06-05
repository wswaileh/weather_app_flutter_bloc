import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/repositories/weather_repo.dart';

/*
 * Weather Events
 */

class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCityWeatherEvent extends WeatherEvent {
  final String _cityName;

  LoadCityWeatherEvent(this._cityName);

  @override
  List<Object> get props => [_cityName];
}

class ResetCityEvent extends WeatherEvent {}

/*
 * Weather States
 */
class WeatherState extends Equatable {
  final String _title;

  WeatherState(this._title);

  String get title => _title;

  @override
  List<Object> get props => [_title];
}

class NoCitySelected extends WeatherState {
  NoCitySelected() : super("Weather App");
}

class LoadCityWeather extends WeatherState {
  LoadCityWeather() : super("");
}

class LoadCityWeatherSuccess extends WeatherState {
  final Weather _weather;

  LoadCityWeatherSuccess(this._weather, title) : super(title);

  Weather get weather => this._weather;

  @override
  List<Object> get props => [_weather];
}

class LoadCityWeatherFailure extends WeatherState {
  LoadCityWeatherFailure() : super("");
}

/*
 * Weather Bloc
 */
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepo _weatherRepo;

  WeatherBloc(this._weatherRepo) : super(NoCitySelected());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is LoadCityWeatherEvent) {
      yield LoadCityWeather();
      try {
        Weather weather = await this._weatherRepo.getWeather(event._cityName);
        yield LoadCityWeatherSuccess(weather, event._cityName);
      } catch (_) {
        yield LoadCityWeatherFailure();
      }
    } else if (event is ResetCityEvent) {
      yield NoCitySelected();
    }
  }
}
