import 'package:http/http.dart'as http;
import'dart:convert';

class NetworkHelper{
  final String  url;
  String ?cityName;
  NetworkHelper(this.url);
  Future<dynamic>getWeatherData( )async{
    http.Response response = await http
        .get(Uri.parse(url),);
    if(response.statusCode==200){
      return jsonDecode(response.body);
    }else{
      print(response.statusCode);
    }
  }



}
const urlMap='api.openweathermap.org/data/2.5/weather';
const apikey='03915a3f84bbb130e6466ebe86a0ee06';
class Model{
  Future<dynamic> getCityWeather(String cityName)async{
    var url='$urlMap?q=$cityName&appid=$apikey&units=metric';
    NetworkHelper networkHelper=NetworkHelper(url);
    var weatherData =await networkHelper.getWeatherData();
    return weatherData;
  }
}