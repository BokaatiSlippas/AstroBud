import 'package:flutter/material.dart';

// A reusable decorated container with consistent styling
class DecoratedBox extends StatelessWidget {
  final Widget child;

  // Creates a decorated box with theme-aware styling
  const DecoratedBox({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
      return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2),
      ),
      child: child
    );
  }
}

/// A standardized widget for displaying metric information with:
/// - Icon representation
/// - Metric label
/// - Current value
/// - Optional info popup
class MetricWidget extends StatelessWidget {

  final String field;
  final String label;
  final IconData icon;
  final String data;
  final bool enablePopup;

  /// Creates a metric display widget
  /// [field]: The metric's identifier (used as fallback for label)
  /// [data]: The current value to display
  /// [icon]: The icon representing this metric
  /// [enablePopup]: Whether to show info popup (defaults to true)
  MetricWidget({
    required this.field,
    required this.data,
    required this.icon,
    this.enablePopup = true
  }) : 
    // Compute label at compile time; fallback to empty string if key not found.
    label = field;



  @override
  Widget build(BuildContext context) {

    return AspectRatio(
      aspectRatio: 6,
      child: DecoratedBox(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, 
        children: [
          // Metric icon
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain, 
              child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
            ),
            flex: 2,
          ),
          // Metric label
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
            flex: 5
          ),
          // Current value
          Expanded(
            child: Text(data, style: Theme.of(context).textTheme.headlineMedium)
          ),
          // Info button (conditionally interactive)
          Expanded(
            child: GestureDetector(
                onTap: () {
                  if (enablePopup) {
                    Navigator.of(context).push(PopupInfo(info: "Placeholder text"));
                  }
                },
                child: FittedBox(
                  fit: BoxFit.contain, 
                  child: Icon(Icons.info_outline_rounded, color: Theme.of(context).colorScheme.onPrimary),
              )
            )
          )
        ],
      ),
      ),
    ));
  }
}

/// A custom popup route for displaying informational content
class PopupInfo extends PopupRoute {
  final String info; // The text content to display

  PopupInfo({required this.info});


  @override
  Color? get barrierColor => Colors.black.withValues(alpha: 0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => "Dismissible";

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Row(
                  children: [Icon(Icons.info_outline_rounded, color: Theme.of(context).colorScheme.onPrimary), 
                  SizedBox(width: 10),
                  Text(info, style: Theme.of(context).textTheme.bodyMedium)]
                  )))
                  );
  }
}