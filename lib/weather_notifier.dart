import 'dart:io';
import "data_model.dart";
import 'package:http/http.dart' as http;
import 'metrics_enum.dart';


class WeatherNotifier {
  // Exposed for practicality, we're ditching this key as soon as the project is over
  // In practice would use .env or something similar
  final String __apiKey = "19eb42b5e8659365a6fdd699f351a51f";
  final DataModel _dataProcessor = DataModel();

  /*// requestLocation - Makes API Call for geo-decoded location
  Future<String> _fetchLocationJSON(String city) async{
    String decoderCall = "http://api.openweathermap.org/geo/1.0/direct?q={$city},&appid={$__apiKey}";

    http.Response coordResponse = await http.get(Uri.parse(decoderCall));

    // Tbc: Error Handling
    if (coordResponse.statusCode != 200){
      int status = coordResponse.statusCode;
      throw HttpException("HTTP Error Code $status when fetching location");
    }

    return coordResponse.body;
  }*/

  // requestData - Makes API Call to get JSON data containing relevant statistics
  Future<String> _fetchStatsJSON(String lat, String long, DateTime timestamp) async{
    String time = timestamp.millisecondsSinceEpoch/1000 as String;

    String dataCall = "https://api.openweathermap.org/data/3.0/onecall/timemachine?lat={$lat}&lon={$long}&dt={$time}&appid={$__apiKey}";
    http.Response weatherResponse = await http.get(Uri.parse(dataCall));

    // TODO: Error Handling
    if (weatherResponse.statusCode != 200){
      int status = weatherResponse.statusCode;
      throw HttpException("HTTP Error Code: $status when fetching statistics");
    }

    return weatherResponse.body;
  }

  // getWeatherFromAPI - Used whenever the page is refreshed, to access statistics from the API
  Future<Map<Metric, String>> getWeatherFromAPI(String lat, String long, DateTime timestamp) async{
    String statsJSON = await _fetchStatsJSON(lat, long, timestamp);
    return _dataProcessor.getStatsFromJSON(statsJSON);
  }
}