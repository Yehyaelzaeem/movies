import 'package:flutter/cupertino.dart';
import 'package:movies/movies/data/respository/detailsresponsitory.dart';
import 'package:movies/movies/data/respository/likethisMoviesRepository.dart';
import 'package:movies/movies/domain/entities/movies_details.dart';
import 'package:movies/movies/domain/usecase/getDetails.dart';
import 'package:movies/movies/domain/usecase/getLikeThisMovies.dart';
import '../../data/datasource/reomteDataSource.dart';
import '../../domain/entities/likeThisMovies.dart';
import '../../domain/respository/baseDetailsRepository.dart';
import '../../domain/respository/baseLikethisRepository.dart';

class DetailsProvider extends ChangeNotifier{
   List<Details> listDetails =[];
   List<LikeThisMovies> listLikeThis=[];



  void getDetails (int id,String lang)async{
    listDetails.clear();
    String l='en';
    if(lang =='ar'){
      l='ar';
    }
    BaseRemoteDateSource baseRemoteDateSource =RemoteDateSource();
    BaseDetailsRepository baseDetailsRepository =DetailsRepository(baseRemoteDateSource);
    final res = await GetMoviesDetails(baseDetailsRepository).getDetailsMovies(id,l);
    listDetails.add(res);
    notifyListeners();
  }

  void getLikeThisMovies (int id) async{
    BaseRemoteDateSource baseRemoteDateSource =RemoteDateSource();
    BaseLikeThisRepository baseLikeThisRepository=LikeThisMoviesRepository(baseRemoteDateSource);
    final res = await GetLikeThisMovies(baseLikeThisRepository).execute(id);
    res.fold((l)=>null,(r)=>{
      listLikeThis=r
    });
    notifyListeners();

  }
}