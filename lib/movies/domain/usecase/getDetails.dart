import 'package:movies/movies/domain/respository/baseDetailsRepository.dart';
import '../entities/movies_details.dart';

class GetMoviesDetails {
  final BaseDetailsRepository baseDetailsRepository;
  GetMoviesDetails(this.baseDetailsRepository);


  Future<Details> getDetailsMovies (int id)async{
    return await baseDetailsRepository.getMoviesDetails(id);
  }
}