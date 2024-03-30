import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_mate_shopping_app/screen/home_screen/home_screen.dart';
import 'package:road_mate_shopping_app/screen/home_screen/home_screen_model.dart';
import 'package:road_mate_shopping_app/utils/res/service_locator_setup.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: HomePage(),
      ),
    );
  }
}
