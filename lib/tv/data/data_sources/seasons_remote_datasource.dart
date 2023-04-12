import 'package:dio/dio.dart';
import 'package:movies/tv/data/models/seasons_tv.dart';
import '../../../constantes/constants.dart';
import '../../../core/networks/error_model.dart';
import '../../../core/networks/exception.dart';

abstract class BaseSeasonsDataSource {
  Future<SeasonsModel> getSeasonsData(int id ,int seasonNumber);
}

class SeasonsDataSource implements BaseSeasonsDataSource{

  @override
  Future<SeasonsModel> getSeasonsData(int id, int seasonNumber) async{
    var res =await Dio().get('${AppConstants.baseUrl}/tv/$id/season/$seasonNumber?api_key=${AppConstants.apiKey}');
    if(res.statusCode==200){
      return SeasonsModel.fromJson(res.data);
    }
    else{
      throw ServerException(errorMessage: ErrorMessageModel.fromJson(res.data));
    }
  }
}