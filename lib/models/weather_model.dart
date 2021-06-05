class Weather {
  int temp;
  int feelsLike;
  int minTemp;
  int maxTemp;

  Weather(double temp, double feelsLike, double minTemp, double maxTemp) {
    this.temp = temp.toInt();
    this.feelsLike = feelsLike.toInt();
    this.minTemp = minTemp.toInt();
    this.maxTemp = maxTemp.toInt();
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        json["temp"], json["feels_like"], json["temp_min"], json["temp_max"]);
  }
}
