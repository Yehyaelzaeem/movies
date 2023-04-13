import 'package:dio/dio.dart';
import 'package:movies/constantes/constants.dart';
import 'package:movies/core/networks/error_model.dart';
import 'package:movies/core/networks/exception.dart';
import 'package:movies/tv/data/models/likethismovies_tv_model.dart';
import 'package:movies/tv/data/models/tv_model.dart';
import '../models/details_tv_model.dart';

abstract class BaseTvRemoteDataSource {
  Future<List<TvModel>> getOnTheAir();
  Future<List<TvModel>> getPopular(int page);
  Future<List<TvModel>> getTopRated(int page);
  Future<DetailsModelTv> getTvDetails(int id);
  Future<List<TvModel>> getTvSearch(String query, int page);
  Future<List<LikeThisMoviesModelTv>> getTvLikeThis(int id);
}

class TvRemoteDataSource implements BaseTvRemoteDataSource{
  @override
  Future<List<TvModel>> getOnTheAir()async {
    var res =await Dio().get('${AppConstants.baseUrl}/tv/on_the_air?api_key=${AppConstants.apiKey}');
    if(res.statusCode==200){
      return List<TvModel>.from((res.data['results'] as List).map((e) => TvModel.fromJson(e)));
    }
    else{
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(res.data));
    }
  }

  @override
  Future<List<TvModel>> getPopular(int page) async{
    var res =await Dio().get('${AppConstants.baseUrl}/tv/popular?api_key=${AppConstants.apiKey}&page=$page');
    if(res.statusCode==200){
      return List<TvModel>.from((res.data['results'] as List).map((e) => TvModel.fromJson(e)));
    }
    else{
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(res.data));
    }
  }

  @override
  Future<List<TvModel>> getTopRated(int page) async{
   var res =await Dio().get('${AppConstants.baseUrl}/tv/top_rated?api_key=${AppConstants.apiKey}&page=$page');
   if(res.statusCode==200){
     return List<TvModel>.from((res.data['results'] as List).map((e) => TvModel.fromJson(e)));
   }
   else{
     throw ServerException(errorMessage: ErrorMessageModel.fromJson(res.data));
   }
  }

  @override
  Future<DetailsModelTv> getTvDetails(int id) async{
    var response = await Dio().get('${AppConstants.baseUrl}/tv/$id?api_key=${AppConstants.apiKey}');
    if(response.statusCode==200){
      return DetailsModelTv.fromJson(response.data);
    }
    else {
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<LikeThisMoviesModelTv>> getTvLikeThis(int id) async{
    var response = await Dio().get('${AppConstants.baseUrl}/tv/$id/recommendations?api_key=${AppConstants.apiKey}');
    if(response.statusCode==200){
      return List<LikeThisMoviesModelTv>.from((response.data['results']as List ).map((e) => LikeThisMoviesModelTv.fromJson(e)));
    }
    else {
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<TvModel>> getTvSearch(String query, int page) async{
    var res =await Dio().get('${AppConstants.baseUrl}/search/tv?api_key=${AppConstants.apiKey}&page=$page&query=$query');
    if(res.statusCode==200){
      return List<TvModel>.from((res.data['results'] as List).map((e) => TvModel.fromJson(e)));
    }
    else{
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(res.data));
    }
  }



}