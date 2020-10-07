import 'package:flutter/material.dart';
import 'package:weatherify/utilities/constants.dart';
import 'package:weatherify/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen(this.weatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var temperature;
  var maxTemp;
  var minTemp;
  var feelsLike;
  int humidity;
  String cityName;
  String weatherMessage;
  String weatherIcon;
  int condition;
  double temp;
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    var weatherData = widget.weatherData;
    updateUI(weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'C';
        cityName = '';
        return;
      }
      temperature = weatherData['main']['temp'];
      maxTemp = weatherData['main']['temp_max'];
      minTemp = weatherData['main']['temp_min'];
      feelsLike = weatherData['main']['feels_like'];
      humidity = weatherData['main']['humidity'];
      condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                      print(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var newCity = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      print(newCity);
                      if (newCity != null) {
                        var weatherData = await weather.getCityWeather(newCity);
                        print(weatherData);
                        print(weatherData['main']['temp']);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Location: $cityName',
                    style: kMessageTextStyle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Temp: $temperature °C',
                    style: kMessageTextStyle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Max temp: $maxTemp °C',
                    style: kMessageTextStyle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Min temp: $minTemp°C',
                    style: kMessageTextStyle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text('Feels Like: $feelsLike °C', style: kMessageTextStyle),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Humidity: $humidity %',
                    style: kMessageTextStyle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Condition: $weatherIcon',
                    style: kMessageTextStyle,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage('images/ic_launcher_round.png'),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Created By Kirti Kunj Bajpai',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Flutter Developer',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Competitive Programmer',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
