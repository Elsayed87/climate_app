import 'package:climate_app/services/weather.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late String weatherIcon;
  late String weatherMessage;
  late String cityName;
  late int temperature;
  @override
  void initState() {
    updataUI(widget.locationWeather);
    super.initState();
  }

  void updataUI(dynamic weatherData) {
    setState(() {
      if(weatherData==null){
        temperature=0;
        weatherIcon='Error';
        weatherMessage='Nothing to display';
        cityName='Nothing';
        return;
      }
      int condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints:  BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: ()async {
                      var weatherData= await weather.getLocationWeather();
                      updataUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedName= await Navigator.push(context,  MaterialPageRoute (
                        builder: (BuildContext context) =>  CityScreen(),
                      ),);
                   if(typedName!=null){
                     var weatherData= await weather.getCityWeather(typedName);
                     updataUI(weatherData);
                   }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// int condition=decodedData['weather'][0]['id'];

// String cityName=decodedData['name'];

// double temperature=decodedData['main']['temp'];



//name    String cityName=jsondecode['name'];
//main.temp double temp=jsondecode['main']['temp'];
//weather[0].id  int condition =jsondecode['weather'][0]['id'];
