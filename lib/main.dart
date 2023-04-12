import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies/presentation/provider/details_provider.dart';
import 'package:movies/tv/presentation/provider/like_this.dart';
import 'package:movies/tv/presentation/provider/season_provider.dart';
import 'package:movies/tv/presentation/provider/tv_provider.dart';
import 'package:provider/provider.dart';
import 'core/services/services_locator.dart';
import 'home.dart';
import 'movies/presentation/provider/playnow_provider.dart';

void main() {
  ServicesLocator().init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<DetailsProvider>(
          create: (context) => DetailsProvider()),
      ChangeNotifierProvider(create: (context) => sl<TvProvider>()),
      ChangeNotifierProvider(create: (context) => sl<PlayNowProvider>()),
      ChangeNotifierProvider(create: (context) => sl<DetailsProviderTv>()),
      ChangeNotifierProvider(create: (context) => sl<SeasonProvider>()),

    ],
    child: DevicePreview(
        enabled: false,
        builder: (context) => const MyApp()),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home());
  }
}
