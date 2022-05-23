import 'package:climate_app/screens/test_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utilities/constants.dart';


class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Model model=Model();
   late double temp;
  late  String cityName;
    int temprature=0;
  @override
  void initState() {

    super.initState();
  }
  void updateUI(dynamic weatherData) {
  setState(() {
    if(weatherData==null){
      temp=0.0;
      return;
    }
    temp=  weatherData['main']['temp'];
    temprature=temp.toInt();
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('APP WEATHER'), backgroundColor: Colors.teal),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.teal.shade400,
        child: Column(
          children: [
            TextField(
              autocorrect: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(

                icon: const Icon(
                  Icons.location_city,
                  color: Colors.white,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter your city name',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,

                ),
              ),
              onChanged: (value) {
               cityName=value;
              },
            ),
            TextButton(
              onPressed: () async{
                 var result= await model.getCityWeather(cityName);
                 updateUI(result);
              },
              child: const Text(
                'Get Weather',
                style: kwtext3style,
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.temperatureFull,
                color: Colors.white,
                size: 40,
              ),
              title: Text('temprature',style: kwtextstyle,),
              subtitle: Text('$temprature°',style: kwtext2style,),
            ),
          ],
        ),
      ),
    );
  }
}
