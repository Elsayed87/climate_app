import '../services/location.dart';
import 'package:climate_app/services/networking.dart';

const kapiKey = '03915a3f84bbb130e6466ebe86a0ee06';
const apiURLMap='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {
  Future<dynamic> getCityWeather(String cityName)async{
    var url='$apiURLMap?q=$cityName&appid=$kapiKey&units=metric';
    NetworkHelper networkHelper=NetworkHelper(url);
   var weatherData =await networkHelper.getData();
   return weatherData;
  }
  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();
    // latitude= location.latitude;
    //longitude=location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        '$apiURLMap?lat=${location.latitude}&lon=${location.longitude}&appid=$kapiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';

    } else if (condition < 400) {
      return '🌧';

    } else if (condition < 600) {
      return '☔️';

    } else if (condition < 700) {
      return '☃️';

    } else if (condition < 800) {
      return '🌫';

    } else if (condition == 800) {
      return '☀️';

    } else if (condition <= 804) {
      return '☁️';

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





