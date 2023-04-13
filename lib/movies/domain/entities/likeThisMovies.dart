
import 'package:equatable/equatable.dart';

class LikeThisMovies extends Equatable{
  final dynamic image;
  final int id;
  final String? lan;

 const LikeThisMovies({required this.image,required this.id,required this.lan,});

  @override
  // TODO: implement props
  List<Object?> get props => [image,id,lan];
}