
import 'package:equatable/equatable.dart';

class LikeThisMovies extends Equatable{
  final dynamic image;
  final int id;

 const LikeThisMovies({required this.image,required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [image,id];
}