import 'package:get_it/get_it.dart';
import 'package:movies/movies/domain/usecase/getPlayNow.dart';
import 'package:movies/tv/data/data_sources/seasons_remote_datasource.dart';
import 'package:movies/tv/data/data_sources/tv_remote_datasource.dart';
import 'package:movies/tv/data/repositories/season_repo.dart';
import 'package:movies/tv/data/repositories/tv_repo.dart';
import 'package:movies/tv/domain/repositories/base_seasons_repo.dart';
import 'package:movies/tv/domain/repositories/base_tv_repo.dart';
import 'package:movies/tv/domain/use_cases/seasons_usecase.dart';
import 'package:movies/tv/domain/use_cases/tv_usecase.dart';
import 'package:movies/tv/presentation/provider/tv_provider.dart';
import '../../movies/data/datasource/reomteDataSource.dart';
import '../../movies/data/respository/responsitory.dart';
import '../../movies/domain/respository/baseResponsitory.dart';
import '../../movies/presentation/provider/playnow_provider.dart';
import '../../tv/data/repositories/likethisMoviesRepositoryTv.dart';
import '../../tv/domain/repositories/baseLikethisRepositoryTv.dart';
import '../../tv/domain/use_cases/getLikeThisMoviesTv.dart';
import '../../tv/presentation/provider/like_this.dart';
import '../../tv/presentation/provider/season_provider.dart';

final sl = GetIt.instance;
class ServicesLocator{

  void init(){
    // Providers
    sl.registerLazySingleton(() => ServicesLocator());
    sl.registerLazySingleton(() => TvProvider(tvUseCase: sl(),));
    sl.registerLazySingleton(() => SeasonProvider(seasonUseCase: sl(),));
    sl.registerLazySingleton(() => DetailsProviderTv(getLikeThisMoviesTvUseCase: sl(),));
    sl.registerLazySingleton(() => PlayNowProvider(getPlayNowUseCase: sl(),));

    /// Use cases
    sl.registerLazySingleton(() => TvUseCase(sl()));
    sl.registerLazySingleton(() => GetPlayNowUseCase(sl()));
    sl.registerLazySingleton(() => SeasonUseCase(sl()));
    sl.registerLazySingleton(() => GetLikeThisMoviesTvUseCase(sl()));

    /// Repositories
    sl.registerLazySingleton<BaseTvRepositories>(() => TvRepositories(sl()));
    sl.registerLazySingleton<BaseSeasonsRepo>(() => SeasonRepo(sl()));
    sl.registerLazySingleton<BaseMoviesRepository>(() => MoviesRepository(sl()));
    sl.registerLazySingleton<BaseLikeThisRepositoryTv>(() => LikeThisMoviesRepositoryTv(sl()));

    /// Data sources
    sl.registerLazySingleton<BaseTvRemoteDataSource>(() => TvRemoteDataSource());
    sl.registerLazySingleton<BaseRemoteDateSource>(() => RemoteDateSource());
    sl.registerLazySingleton<BaseSeasonsDataSource>(() => SeasonsDataSource());

  }
}

