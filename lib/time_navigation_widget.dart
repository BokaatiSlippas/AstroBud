import 'package:flutter/material.dart';

class TimeNavWidget extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final VoidCallback goBack;
  final VoidCallback goNext;

  const TimeNavWidget({super.key, required this.value, required this.onChanged, required this.goBack, required this.goNext});

  // This is passed onto home to allow for time changes, used alongside swipey carousel
  // Methods goNext and goBack are implemented as an alternative for swiping to the next day
  // via pressing the left and right buttons on the bottom
  @override
  Widget build(BuildContext context) {
      return SizedBox (height: 60, child:Row(
        mainAxisSize:MainAxisSize.min,
        children: <Widget>[

          FloatingActionButton.small(
            onPressed: () {goBack();},
            child: const Icon(IconData(0xf572, fontFamily: 'MaterialIcons')),
          ),

          // onChanged is a callback that gets called when the user drags the slider thumb
          // value indicates the current position e.g. if directly press on the navigation bar
          Expanded(child: Slider(
            value:value,
            onChanged:onChanged,
            activeColor: Theme.of(context).colorScheme.primaryContainer,
            min:0.0,
            max:100.0,
          )),

          FloatingActionButton.small(
            onPressed: () {goNext();},
            child: const Icon(IconData(0xf57a, fontFamily: 'MaterialIcons')),
          ),
        ]
      ),);
    }
}
