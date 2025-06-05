import 'package:astronomy_weather_app/day_widget.dart';
import 'package:astronomy_weather_app/time_navigation_widget.dart';
import 'package:astronomy_weather_app/top_bar_widget.dart';
import 'package:astronomy_weather_app/carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

/// The main home page of the astronomy weather app featuring:
/// - A 7-day weather carousel
/// - Time-based navigation controls
/// - Settings access via app bar
class HomePage extends StatefulWidget {
  final String title;

  // Creates the home page with an optional [title]
  const HomePage({super.key, required this.title});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final now = DateTime.now(); // Current date/time reference
  double _timeValue = 0.0; // Current time slider value (0.0-1.0)
  final CarouselSliderController carouselSliderController = CarouselSliderController();

  // Updates the current time value and refreshes the UI
  void updateTimeValue(double value) {
    setState(() {
      _timeValue = value;
    });
  }

  // Navigates to the previous day in the carousel
  void goBack() {
      carouselSliderController.previousPage();
    }

  // Navigates to the next day in the carousel
  void goNext() {
    carouselSliderController.nextPage();
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> dayCards = List<Widget>.generate(7, (index) {
      return DayWidget(dayOffset: index);
    });


    return SafeArea( child: Scaffold(
      primary: true,
      // Top app bar with settings navigation
      appBar: TopBarWidget(onSettingsTap: () {
        Navigator.of(context).pushNamed('/settings')
        .then((_) => setState((){})); // Refresh after returning
      }),
      // Main content area with day carousel
      body: 
          // Carousel at the top
            SwipeyCarousel(
              items: dayCards,
              controller: carouselSliderController,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              autoPlay: false,
            ),
      // Bottom time navigation controls
      bottomNavigationBar: TimeNavWidget(value: _timeValue,
          onChanged: updateTimeValue,
          goBack: goBack, goNext: goNext),
    ));
  }
}
