import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:todo_bloc/core/platform/network_info.dart';
import 'package:todo_bloc/features/album/data/repositories/album_repository_impl.dart';
import 'package:todo_bloc/features/album/domain/usecases/getAlbum.dart';
import 'package:todo_bloc/features/album/domain/usecases/getAlbums.dart';

import 'features/album/data/datasources/album_local_datasource.dart';
import 'features/album/data/datasources/album_remote_datasource.dart';
import 'features/album/domain/repositories/album_repository.dart';
import 'features/album/presentation/bloc/album_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => AlbumBloc(repository: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAlbum(repository: sl()));
  sl.registerLazySingleton(() => GetAlbums(repository: sl()));

  // Repository
  sl.registerLazySingleton<AlbumRepository>(
    () => AlbumRepositoryImpl(
      albumLocalDataSource: sl(),
      networkInfo: sl(),
      albumRemoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AlbumRemoteDataSource>(
    () => AlbumRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<AlbumLocalDataSource>(
    () => AlbumLocalDataSourceImpl(),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
