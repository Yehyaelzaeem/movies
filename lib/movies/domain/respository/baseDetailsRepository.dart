
import '../entities/movies_details.dart';

abstract class BaseDetailsRepository {
   Future<Details> getMoviesDetails(int id);
}