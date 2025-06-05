import 'package:flutter/material.dart';
import 'metrics_enum.dart';
import 'settings_widget.dart';
import 'save_local.dart';


/// A settings page that displays a list of all available metrics with toggle switches
/// to enable/disable their visibility in the app. Persists preferences using local storage
class SettingsPage extends StatelessWidget {
  
  // Future that loads all currently enabled metrics from local storage
  final Future<List<Metric>> enabled = QueryLocal.getAllEnabled();

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Settings", style: Theme.of(context).textTheme.headlineSmall)
      ),

      body: SafeArea(
        child: FutureBuilder(
          future: enabled,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: Metric.values.length,
                  itemBuilder: (context, index) {
                    Metric metric = Metric.values[index];
                    return SettingsWidget(metric: metric, isChecked: snapshot.data!.contains(metric));
                  } 
                );
            }
            // If the data hasn't been fetched yet, we have a loading indicator
            else {
              return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary));
            }
          }
      )),
    );
    
  }
}
