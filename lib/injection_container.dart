import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/interviewers/data/datasources/interviewer_list_local_data_source.dart';
import 'features/interviewers/data/datasources/interviewer_list_remote_data_source.dart';
import 'features/interviewers/data/repositories/interviewer_list_repository_impl.dart';
import 'features/interviewers/domain/repositories/interviewer_list_repository.dart';
import 'features/interviewers/domain/usecases/get_interviewer_list.dart';
import 'features/interviewers/presentation/bloc/interviewer_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Interviewer List
  // Bloc
  sl.registerFactory(
    () => InterviewerListBloc(getInterviewerList: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetInterviewerList(sl()));

  // Repository
  sl.registerLazySingleton<InterviewerListRepository>(
    () => InterviewerListRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<InterviewerListRemoteDataSource>(
    () => InterviewerListRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<InterviewerListLocalDataSource>(
    () => InterviewerListLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
