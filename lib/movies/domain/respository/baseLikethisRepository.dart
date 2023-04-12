import 'package:dartz/dartz.dart';
import 'package:movies/movies/domain/entities/likeThisMovies.dart';
import '../../../core/networks/failure.dart';

abstract class BaseLikeThisRepository {
  Future<Either<Failure,List<LikeThisMovies>>> getLikeThisMovies(int id);
}