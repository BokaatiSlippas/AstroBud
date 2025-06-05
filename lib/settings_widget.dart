import 'package:astronomy_weather_app/save_local.dart';
import 'package:astronomy_weather_app/metric_widget.dart';
import 'package:flutter/material.dart';
import 'metrics_enum.dart';


/// A settings row widget that combines a [Checkbox] with a [MetricWidget] to allow
/// users to toggle the visibility/availability of specific metrics in the app
///
/// Persists changes via [QueryLocal] to maintain state between app launches.
class SettingsWidget extends StatefulWidget {
  final Metric metric;
  final bool isChecked;
  
  // Creates a settings row for a specific metric
  const SettingsWidget({required this.metric, required this.isChecked, super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  // Tracks the current toggle state (initialized from widget.isChecked)
  late bool _isChecked = widget.isChecked;


  void _onChanged(bool? newValue) {
    if (newValue == null) return;
    // Update Local Storage based on the new state to persist the chance
    else if (newValue) {
      QueryLocal.setEnabled(widget.metric);
    } else {
      QueryLocal.setDisabled(widget.metric);
    }
    setState(() {
      _isChecked = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: _onChanged,
          activeColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        // We disabled interaction for the settings view
        Expanded(child: MetricWidget(field: widget.metric.field, data: widget.metric.defaultData, icon: widget.metric.icon, enablePopup: false)),
      ],
    );
}
}
