import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_time_wearher_app/app/pages/home_page/home_controller.dart';
import 'package:http/http.dart' as http;
// class HomePage extends StatelessWidget {

//const HomePage({super.key});

//   final WeatherController weatherController = Get.put(WeatherController());
//   final TextEditingController _cityController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           // Your UI content here
//           ),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String API_KEY = 'ecf20d7af66b4976935220418240501'; //key api
  String location = 'aldeias altas'; //deafult location
  String weatherIcon = 'heayycloud.png';
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  String correntDate = '';

  List hourlWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherStatus = "";

//API call
  String searchWeatherAPI =
      "http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=aldeias%20altas&aqi=";

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherAPI + searchText));

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'no data');

      var locationData = weatherData["location"];
      var currentWeather = weatherData["current"];

      setState(() {
        //debug print(location)
        location = locationData["name"];
        print(location);
      });
    } catch (e) {}
  }

@override
void initState() {
    // TODO: implement initState
    fetchWeatherData(location);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
