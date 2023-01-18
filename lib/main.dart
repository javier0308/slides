import 'package:flutter/material.dart';
import 'package:slide_show_perso/screens/screens.dart';
import 'package:slide_show_perso/screens/slideshow_original.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slide Show',
      initialRoute: SlideshowScreenO.route,
      routes: {
        SlideShowScreen.route: (context) => const SlideShowScreen(),
        SlideshowScreenO.route: (context) => const SlideshowScreenO(),
      },
    );
  }
}
