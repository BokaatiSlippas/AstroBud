import 'package:flutter/material.dart';
import 'package:astronomy_weather_app/metric_widget.dart';
import 'save_local.dart';
import 'metrics_enum.dart';



/// A stateless widget that displays a list of weather metrics (e.g., temperature, humidity)
/// fetched from the API. Each metric is rendered as a [MetricWidget] with customizable
/// properties such as field name, data value, and an icon
/// This widget uses [FutureBuilder] to asynchronously load enabled metrics from the API
/// and displays a loading indicator while waiting for data
class WeatherWidget extends StatelessWidget {
  // Future that loads all enabled metrics from the API
  // The data is retrieved using [QueryLocal.getAllEnabled()]
  final Future<List<Metric>> futureEnabled = QueryLocal.getAllEnabled();
  
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: futureEnabled,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            padding: EdgeInsets.only(top: 10),
              itemCount: snapshot.data!.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return MetricWidget(
                  field: snapshot.data![index].field,
                  data: snapshot.data![index].defaultData,
                  icon: snapshot.data![index].icon,
                  enablePopup: true
                );
            },
          );
        }
        // If the data hasn't been fetched yet, we have a loading indicator
        else {
          return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary));
        }
      },
    );

  }
}

