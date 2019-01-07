import 'package:fancy_weather/forecast/background/background_with_rings.dart';
import 'package:fancy_weather/forecast/background/rain.dart';
import 'package:fancy_weather/forecast/forecast_list.dart';
import 'package:flutter/material.dart';

class Forecast extends StatelessWidget {

  final RadialListViewModel radialList;
  final SlidingRadialListController slidingListController;

  Forecast({
    @required this.radialList,
    @required this.slidingListController,

  });

  Widget _temperatureText() {
    return new Align(
      alignment: Alignment.centerLeft,
      child: new Padding(
        padding: const EdgeInsets.only(top:0.0, left: 10.0),
        child:  new Text(
          '76°F',
          style: new TextStyle(
            color: Colors.white,
            fontSize: 65.0
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
      return new Stack(
        children: <Widget>[
          new BackgroundWithRings(),
          
          _temperatureText(),

          new SlidingRadialList(
            radialList: radialList,
            controller: slidingListController,
          ),

          new Rain()

        ],
      );
  }
}