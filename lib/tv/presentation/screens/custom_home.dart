import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/tv/presentation/screens/details_tv.dart';

import '../../../constantes/constants.dart';
import '../widget/custom_one_movie.dart';
import '../widget/custom_rowTitle.dart';
import '../widget/custom_stack.dart';
class CustomHomeTv extends StatelessWidget {
  final String title;
  final String movieTitle;
  final String image;
  final List listPopular;
  final List listTopRated;
  void Function()? onTapPopular;
  void Function()? onTapTopRated;

  CustomHomeTv(
  {super.key,
   required this.title,
   required this.movieTitle,
   required this.image,
   required this.listPopular,
   required this.listTopRated,
   required this.onTapPopular,
   required this.onTapTopRated
});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomStackTv(
            image:'${AppConstants.imageUrl}$image',
            title: title,
            movieName:movieTitle,
          ),
          CustomRowTitleTv(title: 'Popular',
            onTap:onTapPopular),
          SizedBox(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listPopular.length,
                itemBuilder: (context, i) {
                  if (listPopular.isEmpty || listPopular == [])
                  {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else
                  {
                    return CustomOneMovieTv(
                        image:'${AppConstants.imageUrl}${listPopular[i].posterImage}',
                        onTap: (){
                          print('${listPopular[i].id}');
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsTv(id:listPopular[i].id, lang: listPopular[i].lang,)));
                        });
                  }

                }),
          ),
          CustomRowTitleTv(title: 'Top Rated', onTap:onTapTopRated,),
          SizedBox(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listTopRated.length,
                itemBuilder: (context, i) {
                  if (listTopRated.isEmpty ||
                      listTopRated == []) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return
                      CustomOneMovieTv(
                          image:'${AppConstants.imageUrl}${listTopRated[i].posterImage}',
                          onTap: (){
                            print('${listTopRated[i].id}');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsTv(id:listTopRated[i].id, lang: listTopRated[i].lang,)));
                          });
                  }
                }),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
