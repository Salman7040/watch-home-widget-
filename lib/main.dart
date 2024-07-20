import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widget/get_lat_long_screen.dart';
import 'package:homescreen_widget/time_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(const MyApp());
}

// Called when Doing Background Work initiated from Widget
Future<void> backgroundCallback(Uri? uri) async {

  if (uri?.host == 'updatecounter') {

    String week='',time='',date='';
    DateTime now = DateTime.now();



  //for week
    await HomeWidget.getWidgetData<String>('week', defaultValue: ' ').then((value) {
      week = value!;
      week=TimeScreen.getWeek(now);
    });
    await HomeWidget.saveWidgetData<String>('week', week);

    // for time
    await HomeWidget.getWidgetData<String>('time', defaultValue: ' ').then((value) {
      time = value!;
      time=TimeScreen.getTime(now);
    });
    await HomeWidget.saveWidgetData<String>('week', week);

    //for week
    await HomeWidget.getWidgetData<String>('date', defaultValue: ' ').then((value) {
      date = value!;
      date=TimeScreen.getDate(now);
    });
    await HomeWidget.saveWidgetData<String>('week', week);


    await HomeWidget.updateWidget(
      //this must the class name used in .Kt
        name: 'HomeScreenWidgetProvider',
        iOSName: 'HomeScreenWidgetProvider');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  String week='',time='',date='';
  @override

  void initState() {
    super.initState();
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    loadData(); // This will load data from widget every time app is opened

    Timer.periodic(Duration(seconds: 1), (timer) {
      updateAppWidget();
      setState(() {
        DateTime now = DateTime.now();
        week=TimeScreen.getWeek(now);
        time=TimeScreen.getTime(now);
        date=TimeScreen.getDate(now);
        // print("Current Week: "+TimeScreen.getWeek(now));
        // print("Current Time: "+TimeScreen.getTime(now));
        // print("Current Date: "+TimeScreen.getDate(now));
      });

    });
  }

  void loadData() async {
    await HomeWidget.getWidgetData<String>('week', defaultValue: " ").then((value) {
      week = value!;
    });
    await HomeWidget.getWidgetData<String>('time', defaultValue: " ").then((value) {
      time = value!;
    });
    await HomeWidget.getWidgetData<String>('date', defaultValue: " ").then((value) {
      date = value!;
    });
    setState(() {});
  }

  Future<void> updateAppWidget() async {

    await HomeWidget.saveWidgetData<String>('week',week);
    await HomeWidget.saveWidgetData<String>('time',time);
    await HomeWidget.saveWidgetData<String>('date',date);
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Current Week: ${week}"),
            Text("Current Time: ${time}"),
            Text("Current Date: ${date}"),
          ],
        ),
      ),

    );
  }
}
