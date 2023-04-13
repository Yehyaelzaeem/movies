import 'package:movies/movies/data/datasource/reomteDataSource.dart';
import 'package:movies/movies/domain/entities/movies_details.dart';
import 'package:movies/movies/domain/respository/baseDetailsRepository.dart';

class DetailsRepository extends BaseDetailsRepository{
  final BaseRemoteDateSource baseRemoteDateSource ;

  DetailsRepository(this.baseRemoteDateSource);

  @override
  Future<Details> getMoviesDetails(int id,String lang) async{
   return await baseRemoteDateSource.getDetails(id,lang);
  }

}