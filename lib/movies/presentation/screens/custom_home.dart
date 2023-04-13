import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constantes/constants.dart';
import 'details.dart';
import '../widget/custom_one_movie.dart';
import '../widget/custom_rowTitle.dart';
import '../widget/custom_stack.dart';

class CustomHome extends StatelessWidget {
  final String title;
  final String movieTitle;
  final String image;
  final List listPopular;
  final List listTopRated;
  void Function()? onTapPopular;
  void Function()? onTapTopRated;

  CustomHome(
      {super.key,
      required this.title,
      required this.movieTitle,
      required this.image,
      required this.listPopular,
      required this.listTopRated,
      required this.onTapPopular,
      required this.onTapTopRated});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomStack(
            image: '${AppConstants.imageUrl}$image',
            title: title,
            movieName: movieTitle,
          ),
          CustomRowTitle(title: 'Popular', onTap: onTapPopular),
          SizedBox(
            height: 180,
            child:
            ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listPopular.length,
                itemBuilder: (context, i) {
                  if (listPopular.isEmpty || listPopular == []) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return CustomOneMovie(
                        image:
                            '${AppConstants.imageUrl}${listPopular[i].posterImage}',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsMovies(id: listPopular[i].id, lang: listPopular[i].lan,)));
                        });
                  }
                }),
          ),
          CustomRowTitle(
            title: 'Top Rated',
            onTap: onTapTopRated,
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listTopRated.length,
                itemBuilder: (context, i) {
                  if (listTopRated.isEmpty || listTopRated == []) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return CustomOneMovie(
                        image:
                            '${AppConstants.imageUrl}${listTopRated[i].posterImage}',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsMovies(id: listTopRated[i].id, lang: listTopRated[i].lan,)));
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
