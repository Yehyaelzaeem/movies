import 'package:dio/dio.dart';
import 'package:movies/constantes/constants.dart';
import 'package:movies/core/networks/error_model.dart';
import 'package:movies/core/networks/exception.dart';
import 'package:movies/movies/data/model/likethismovies_model.dart';
import 'package:movies/movies/data/model/movies_model.dart';
import '../model/details_model.dart';

abstract class BaseRemoteDateSource {
  Future<List<MoviesModel>> getMoviesPlayNow(int page);
  Future<List<MoviesModel>> getMoviesPopular(int page);
  Future<List<MoviesModel>> getMoviesTopRated(int page);
  Future<DetailsModel> getDetails(int id);
  Future<List<LikeThisMoviesModel>> getLikeThisMovies(int id);
}

class RemoteDateSource implements BaseRemoteDateSource{

  @override
  Future<List<MoviesModel>> getMoviesPlayNow(int page)async{
    var response = await Dio().get('${AppConstants.baseUrl}/movie/now_playing?api_key=${AppConstants.apiKey}&page=$page');
    if(response.statusCode==200){
      return List<MoviesModel>.from((response.data['results'] as List).map((e) => MoviesModel.fromJson(e)));
    }
    else {
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(response.data));
    }
   }


  @override
  Future<List<MoviesModel>> getMoviesPopular(int page)async{
    var response = await Dio().get('${AppConstants.baseUrl}/movie/popular?api_key=${AppConstants.apiKey}&page=$page');
    if(response.statusCode==200){
      return List<MoviesModel>.from((response.data['results'] as List).map((e) => MoviesModel.fromJson(e)));
    }
    else {
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(response.data));
    }
  }


  @override
  Future<List<MoviesModel>> getMoviesTopRated(int page)async{
    var response = await Dio().get('${AppConstants.baseUrl}/movie/top_rated?api_key=${AppConstants.apiKey}&page=$page');
    if(response.statusCode==200){
      return List<MoviesModel>.from((response.data['results'] as List).map((e) => MoviesModel.fromJson(e)));
    }
    else {
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(response.data));
    }
  }


  @override
  Future<DetailsModel> getDetails(int id) async{
    var response = await Dio().get('${AppConstants.baseUrl}/movie/$id?api_key=${AppConstants.apiKey}');
    if(response.statusCode==200){
      return DetailsModel.fromJson(response.data);
    }
    else {
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<LikeThisMoviesModel>> getLikeThisMovies(int id) async{
    var response = await Dio().get('${AppConstants.baseUrl}/movie/$id/recommendations?api_key=${AppConstants.apiKey}');
    if(response.statusCode==200){
      return List<LikeThisMoviesModel>.from((response.data['results']as List ).map((e) => LikeThisMoviesModel.fromJson(e)));
    }
    else {
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(response.data));
    }
  }

}
