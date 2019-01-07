import 'package:fancy_weather/forecast/app_bar.dart';
import 'package:fancy_weather/forecast/background/forecast.dart';
import 'package:fancy_weather/forecast/forecast_list.dart';
import 'package:fancy_weather/forecast/week_drawer.dart';
import 'package:fancy_weather/generic_widgets/sliding_drawer.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  OpenableController openableController;
  SlidingRadialListController slidingListController;
  String selectedDay = week.first;

  @override
  void initState() {
    super.initState();
    openableController = new OpenableController(
        vsync: this, openDuration: const Duration(milliseconds: 250))
      ..addListener(() => setState(() {}))
      ..open();
    slidingListController = new SlidingRadialListController(
      itemCount: forecastRadialList.items.length,
      vsync: this,
    )
    ..open();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        new Forecast(
          radialList: forecastRadialList,
          slidingListController: slidingListController,
        ),
        new Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: new ForecastAppBar(
            onDrawerArrowTap: openableController.open,
            selectedDay: selectedDay.replaceAll('\n', ', '),
          ),
        ),
        new SlidingDrawer(
          openableController: openableController,
          drawer: new WeekDrawer(
            onDaySelected: (String title) {
              setState(() {
                selectedDay = title.replaceAll('\n', ', ');
              });

              slidingListController
                  .close()
                  .then((_) => slidingListController.open());
              openableController.close();
            },
          ),
        )
      ],
    ));
  }
}
