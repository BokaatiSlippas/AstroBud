import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SwipeyCarousel extends StatelessWidget {
  final List<Widget> items;
  final double height;
  final double width;
  final bool autoPlay;
  final CarouselSliderController controller;
  
  // We define and set the carousel values, these are changed later as in home.dart
  const SwipeyCarousel({
    super.key,
    required this.items,
    required this.controller,
    this.height = 0,
    this.width = 0,
    this.autoPlay = true,
  });

  // There are a few basic options set, some of which are changed later e.g. autoplay is set to false in home.dart
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        aspectRatio: 16/9,
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: autoPlay,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: items,
      carouselController: controller,
    );
  }
}