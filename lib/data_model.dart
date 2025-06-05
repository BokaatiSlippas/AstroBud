import 'dart:math' as math;
import 'dart:convert';
import 'metrics_enum.dart';
import 'package:intl/intl.dart' as intl;


class DataModel {
  // getStatsFromJSON - Parses JSON and extract features that our system supports
  Map<Metric, String> getStatsFromJSON(String jsonString){

    Map<Metric, String> result = Map<Metric, String>();

    // Unpack data
    Map<String, dynamic> parsedData = jsonDecode(jsonString)["data"][0];

    // Repack it to be sent off
    result[Metric.visibility] = parsedData["visibility"];
    result[Metric.cloudCover] = parsedData["cloudiness"];

    result[Metric.sunrise] = _getTimeFromUnixStamp(parsedData["sunrise"]);
    result[Metric.sunset] = _getTimeFromUnixStamp(parsedData["sunset"]);

    double windSpeed = double.parse(parsedData["wind_speed"]);
    result[Metric.beaufort] = _getBeaufortFromWindMPS(windSpeed);

    result[Metric.temperature] = _kelvinToCelsius(parsedData["temp"]);
    result[Metric.precipitation] = parsedData["rainfall"];
    result[Metric.pressure] = parsedData["pressure"];

    return result;
  }

  String _getBeaufortFromWindMPS(double v){
    return math.pow(v/0.836, 2/3) as String;
  }

  String _kelvinToCelsius(String T) => ((double.parse(T) - 273.15) as String);

  String _getTimeFromUnixStamp(String timestamp){
    DateTime time = DateTime.fromMillisecondsSinceEpoch((timestamp as int)*1000, isUtc: false);
    intl.DateFormat formatter = intl.DateFormat.Hm();
    return formatter.format(time);
  }

}