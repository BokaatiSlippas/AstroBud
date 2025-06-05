import 'package:flutter/material.dart';
import 'package:astronomy_weather_app/weather_widget.dart';

// Displays weather information for a specific day, including:
// - Date header card
// - Future weather data with loading state
class DayWidget extends StatelessWidget {
  final int dayOffset; // Days from current date (0 = today, 1 = tomorrow, etc.)

  // Creates a day widget for the specified offset from current date
  const DayWidget({super.key, required this.dayOffset});
  


  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();

    DateTime widgetDate = now.add(Duration(days: dayOffset));

    String dayName = (dayOffset == 0) ? "Today" : ((dayOffset==1) ? "Tomorrow": ( "${widgetDate.day}-${widgetDate.month}-${widgetDate.year}" ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          width: MediaQuery.of(context).size.width * 0.9, // 90% of the screen's width
          //padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              dayName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ),

        Expanded(child: FutureWeather(weatherInfo: Future.delayed(Duration(seconds: 2), () {
          return "placeholder";
        })))
      ]
    );
  }
}

/// Handles asynchronous weather data loading and display
class FutureWeather extends StatelessWidget {
  // (use generics when implementing)
  final Future weatherInfo;

  // Creates a widget that displays weather information when available
  const FutureWeather({required this.weatherInfo});

  Widget handleFuture (data) {
    return Column(
      children: [FittedBox(child: Placeholder()),
        Expanded(child: WeatherWidget())],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weatherInfo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return handleFuture(snapshot.data!);
        }
        // If the data hasn't been fetched yet, we have a loading indicator
        else {
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary)
          );
        }
      }

    );
  }
}
