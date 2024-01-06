
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WeatherController extends GetxController {

  var location = 'London'.obs;
  var weatherIcon = 'heavycloud.png'.obs;
  var temperature = 0.obs;
  var windSpeed = 0.obs;
  var humidity = 0.obs;
  var cloud = 0.obs;
  var currentDate = ''.obs;

  var hourlyWeatherForecast = [].obs;
  var dailyWeatherForecast = [].obs;

  var currentWeatherStatus = ''.obs;

  final searchWeatherAPI =
      "https://api.weatherapi.com/v1/forecast.json?key=YOUR_API_KEY&days=7&q=";

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult = await http.get(Uri.parse(searchWeatherAPI + searchText));

      final weatherData =
          Map<String, dynamic>.from(json.decode(searchResult.body) ?? {});

      var locationData = weatherData["location"];
      var currentWeather = weatherData["current"];

      location.value = getShortLocationName(locationData["name"]).toString();

      var parsedDate =
          DateTime.parse(locationData["localtime"].substring(0, 10));
      var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
      currentDate.value = newDate.toString();

      currentWeatherStatus.value = currentWeather["condition"]["text"];

      weatherIcon.value =
          currentWeatherStatus.value.replaceAll(' ', '').toLowerCase() +
              ".png";
      temperature.value = currentWeather["temp_c"].toInt();
      windSpeed.value = currentWeather["wind_kph"].toInt();
      humidity.value = currentWeather["humidity"].toInt();
      cloud.value = currentWeather["cloud"].toInt();

      dailyWeatherForecast.value = weatherData["forecast"]["forecastday"];
      hourlyWeatherForecast.value = dailyWeatherForecast[0]["hour"];
    } catch (e) {
      print(e.toString());
    }
  }

  static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + " " + wordList[1];
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }
}