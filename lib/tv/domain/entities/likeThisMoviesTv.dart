
import 'package:equatable/equatable.dart';

class LikeThisMoviesTv extends Equatable{
  final dynamic image;
  final int id;
  final String? lang;

 const LikeThisMoviesTv({required this.image,required this.id,required this.lang, });

  @override
  List<Object?> get props => [image,id,lang];
}