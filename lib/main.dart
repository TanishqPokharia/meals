import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screens/tabs.dart';

void main() {
  runApp(const ProviderScope(child: MealsApp()));
}

class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meals App ${1 + 2}',
        theme: ThemeData().copyWith(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey.shade900,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            textTheme: const TextTheme(
                titleSmall: TextStyle(fontSize: 14),
                titleMedium: TextStyle(fontSize: 24),
                titleLarge: TextStyle(fontSize: 30))),
        home: const TabsScreen());
  }
}
