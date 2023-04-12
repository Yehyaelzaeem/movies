
import 'package:equatable/equatable.dart';

class LikeThisMoviesTv extends Equatable{
  final dynamic image;
  final int id;

 const LikeThisMoviesTv({required this.image,required this.id});

  @override
  List<Object?> get props => [image,id];
}