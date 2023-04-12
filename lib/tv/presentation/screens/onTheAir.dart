import 'package:flutter/material.dart';
import 'package:movies/tv/presentation/provider/tv_provider.dart';
import 'package:movies/tv/presentation/screens/custom_home.dart';
import 'package:provider/provider.dart';
import 'custom_display_movies.dart';

class OnTheAir extends StatelessWidget {
  const OnTheAir({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      toolbarHeight: 10,
      backgroundColor: Colors.black,
    );
    return Scaffold(
        appBar:appbar ,
        backgroundColor: const Color(0xff303030),
        body:
        Consumer<TvProvider>(
        builder: (context,controller,child){
          if(controller.listOnTheAir.isEmpty){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            return  CustomHomeTv(
              title: 'ON THE AIR',
              movieTitle: controller.listOnTheAir[0].title,
              image: controller.listOnTheAir[0].image,
              listPopular: controller.listTvPopularDate,
              listTopRated: controller.listTvTopRatedDate,
              onTapPopular: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    const CustomDisplayTv( title: 'Popular Tv', isPopular: true,)
                ));
                },
              onTapTopRated: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                   const CustomDisplayTv(title: 'Top Rated Tv', isPopular: false,)
                ));
                },
            );
          }
        },
      )
    );

  }
}
