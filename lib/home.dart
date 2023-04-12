import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:movies/movies/presentation/screens/nowplaying.dart';
import 'package:movies/tv/presentation/provider/tv_provider.dart';
import 'package:movies/tv/presentation/screens/onTheAir.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'core/services/services_locator.dart';
import 'movies/presentation/provider/playnow_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

int selected = 0;
class _HomeState extends State<Home> {

  @override
  void initState() {
    sl<PlayNowProvider>().initA(true);
    sl<TvProvider>().init(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,)
        {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return Scaffold(
              body: selected == 0 ? const NowPlaying() : const OnTheAir(),
              bottomNavigationBar: SizedBox(
                height: 55,
                child: WaterDropNavBar(
                  bottomPadding: 7,
                  waterDropColor: Colors.white,
                  backgroundColor: const Color(0xff303030),
                  onItemSelected: (index) {
                    setState(() {
                      selected = index;
                    });
                  },
                  selectedIndex: selected,
                  barItems: [
                    BarItem(
                      filledIcon: Icons.movie,
                      outlinedIcon: Icons.movie_creation_outlined,
                    ),
                    BarItem(
                        filledIcon: Icons.ondemand_video_outlined,
                        outlinedIcon: Icons.personal_video_outlined),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/g.png',fit: BoxFit.cover,),
                  ),
                   Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      "Can't Connect ....Check The Internet",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            );
          }
        },
        child: const Center(child: CircularProgressIndicator()));
  }
}

