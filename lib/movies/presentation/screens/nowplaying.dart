import 'package:flutter/material.dart';
import 'package:movies/movies/presentation/screens/custom_home.dart';
import 'package:movies/movies/presentation/provider/playnow_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/services/services_locator.dart';
import 'custom_display_movies.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      toolbarHeight: 10,
      backgroundColor: Colors.black,
    );
    var mqHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appbar.preferredSize.height;
    var mqWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: appbar,
        backgroundColor: const Color(0xff303030),
        body:
        Consumer<PlayNowProvider>(
          builder: (context, controller, child) {
            if (controller.listPlayNow.isEmpty || controller.listPlayNow == []) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return
                CustomHome(
                  title: 'Now Playing',
                  movieTitle: controller.listPlayNow[0].title!,
                  image: controller.listPlayNow[0].image!,
                  listPopular: controller.listPopularData,
                  listTopRated: controller.listTopRatedData,
                onTapPopular: () {
                    controller.isPopularMovies=true;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      const CustomDisplayMovies( title: 'Popular Movies',
                        isPopular: true,)
                  ));
                }, onTapTopRated: () {
                controller.isPopularMovies=false;
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                const CustomDisplayMovies( title: 'Top Rated Movies',
                  isPopular: false,)
                ));
              },
              );
            }
          },
        ));
  }
}
