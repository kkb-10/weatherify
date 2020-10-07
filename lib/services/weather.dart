import 'package:weatherify/services/location.dart';
import 'package:weatherify/services/networking.dart';

const String apiKey = 'd6dc32ada3d4ef32e33afba0cb0860a4';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    return await networkHelper.getData();
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    return await networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'ThunderStorm 🌩';
    } else if (condition < 400) {
      return 'Drizzle 🌧';
    } else if (condition < 600) {
      return 'Rain ☔️';
    } else if (condition < 700) {
      return 'Snow ☃️';
    } else if (condition <= 800) {
      return 'Clear ☀️';
    } else if (condition <= 804) {
      return 'Cloudy ☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
