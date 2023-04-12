import 'package:movies/core/networks/error_model.dart';

class ServerException implements Exception{
  final ErrorMessageModel errorMessage ;

  ServerException({required this.errorMessage});
}