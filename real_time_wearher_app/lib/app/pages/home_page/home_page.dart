import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  String location = 'Cape Town'; //deafult location
  String weatherIcon = 'heayycloud.png';
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  var currentDate;

  List hourlWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherStatus = "";

//API call
  String searchWeatherAPI =
      "http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=";

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherAPI + searchText));

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'no data');

      var locationData = weatherData["location"];
      var currentWeather = weatherData["current"];

      setState(
        () {
          //debug print(location)
          location = getShortLocationName(locationData["name"]);
          print(location);

          var parseDate =
              DateTime.parse(locationData["localtime"].substring(0, 10));
          var newDate = DateFormat('MMM EEE dd').format(parseDate);
          currentDate = newDate;

          currentWeatherStatus = currentWeather['condition']['text'];
          weatherIcon =
              currentWeatherStatus.replaceAll(' ', '').toLowerCase() + '.png';
          temperature = currentWeather["temp.c"].toInt();
          windSpeed = currentWeather["wind_kph"].toInt();
          humidity = currentWeather["humidity"].toInt();
          cloud = currentWeather["cloud"].toInt();

          print(newDate);
          print(currentWeatherStatus);
          print(weatherIcon);
          print(temperature);
          print(windSpeed);
          print(humidity);
          print(cloud);
        },
      );
    } catch (error) {
      print('Erro na requisição: $error');
    }
  }

  //função para retornar o primeiro 2 nomes da string de localização
  static String getShortLocationName(String s) {
    List<String> wordList = s.split('');
    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return '${wordList[0]} ${wordList[1]}';
      } else {
        return wordList[0];
      }
    } else {
      return '';
    }
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
