import 'package:flutter/cupertino.dart';
import 'package:movies/tv/domain/entities/likeThisMoviesTv.dart';
import '../../domain/use_cases/getLikeThisMoviesTv.dart';

class DetailsProviderTv extends ChangeNotifier{
  final GetLikeThisMoviesTvUseCase getLikeThisMoviesTvUseCase;
  DetailsProviderTv({required this.getLikeThisMoviesTvUseCase});


   List<LikeThisMoviesTv> listLikeThis=[];

  void getLikeThisMovies (int id) async{
    listLikeThis.clear();
    final data =await getLikeThisMoviesTvUseCase.execute(id);
    listLikeThis=data;
    notifyListeners();

  }
}