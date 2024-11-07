import 'package:exhange_rates_flutter/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Currency Exchange',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Color.fromARGB(255, 38, 35, 35),
              foregroundColor: Colors.white //here you can give the text color
              ),
          primaryColor: Colors.grey,
          scaffoldBackgroundColor:Color.fromARGB(255, 38, 35, 35),
        ),
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}
