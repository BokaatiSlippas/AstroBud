import 'package:flutter/material.dart';
import 'package:astronomy_weather_app/search_dropdown.dart';


/// Location selection page that displays:
/// - A decorative astronomy-themed image
/// - A searchable dropdown for location selection
/// - Navigation back to the home screen
class LocPage extends StatefulWidget {

  // Creates a location page with required [title]
  final String title;

  const LocPage({super.key, required this.title});

  @override
  State<LocPage> createState() => _LocPageState();

}


class _LocPageState extends State<LocPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set background color to match theme's primary color
      backgroundColor: Theme.of(context).colorScheme.primary,

      body: SizedBox.expand( child:Column(
          spacing: 50,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          // Location page's 'map'
          SizedBox(
              width: 300,
              child: Container( decoration: BoxDecoration(
              border: Border.all(width: 5, color: Theme.of(context).colorScheme.primaryContainer),
              borderRadius: BorderRadius.circular(40),
               ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://t3.ftcdn.net/jpg/00/56/43/30/360_F_56433018_YFPP9CW7ZIXJZonqX9kpVfPeh0KzWxCv.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ),
          // Search dropdown component
          SearchDropdown(),
            ]
           )
        ),
        // Back navigation
        floatingActionButton: FloatingActionButton.small(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Icon(IconData(0xf107, fontFamily: 'MaterialIcons')),
        ),
    );
  }
}
