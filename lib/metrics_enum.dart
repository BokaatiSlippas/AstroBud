import 'package:flutter/material.dart';

enum Metric {
  // Default Metrics
  cloudCover(field: "cloud cover", defaultData: "4", icon: Icons.cloud),
  temperature(field: 'temperature (°C)', defaultData: '22', icon: Icons.thermostat),
  humidity(field: 'humidity (%)', defaultData: '50', icon: Icons.water_drop),
  sunrise(field: 'sunrise time', defaultData: '06:00', icon: Icons.sunny),
  sunset(field: 'sunset time', defaultData: '20:00', icon: Icons.wb_twilight_rounded),
  precipitation(field: 'Precipitation', defaultData: '', icon: Icons.shower_rounded),
  visibility(field: 'Visibility', defaultData: '', icon: Icons.visibility),
  beaufort( field: 'Beaufort', defaultData: '', icon: Icons.air),
  pressure(field: 'Pressure',  defaultData: '', icon: Icons.storm);

  // Enhanced Metric

  final String field;
  final String defaultData;
  final IconData icon;

  const Metric({required this.field, required this.defaultData, required this.icon});
}
