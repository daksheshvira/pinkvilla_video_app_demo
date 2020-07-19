import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinkvilla_video_app_demo/ui/HomeScreen.dart';
import 'package:pinkvilla_video_app_demo/utils/Constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorObservers: <NavigatorObserver>[
      routeObserver,
    ],
    title: 'PinkVilla Shorts',
    home: HomeScreen(),
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => HomeScreen(),
    },
  ));
}
