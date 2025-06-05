import 'package:flutter/material.dart';
import 'package:astronomy_weather_app/save_local.dart';

/// A custom app bar widget that displays:
/// - A location navigation button (left)
/// - A centered title - defaulted as Birmingham but choose from dropdown
/// - A settings button (right)
class TopBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onSettingsTap;
  
  const TopBarWidget({required this.onSettingsTap, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  String _location = 'Loading...'; // Initial placeholder

  @override
  void initState() {
    super.initState();
    _loadLocation(); // Load location when widget initializes
  }

  Future<void> _loadLocation() async {
    try {
      final city = await QueryLocal.getSelectedCity();
      if (mounted) {
        setState(() {
          _location = city.displayName();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _location = 'Birmingham'); // Fallback
      }
      debugPrint('Error loading location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton.small(
          onPressed: () async {
            await Navigator.pushNamed(context, '/location');
            _loadLocation(); // Refresh after returning from location page
          },
          child: const Icon(IconData(0xf193, fontFamily: 'MaterialIcons')),
        ),
        
        Expanded(
          child: Center(
            child: FittedBox(
              child: Text(
                _location,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),

        FloatingActionButton.small(
          onPressed: widget.onSettingsTap,
          child: const Icon(IconData(0xe57f, fontFamily: 'MaterialIcons')),
        ),
      ],
    );
  }
}