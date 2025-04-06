import 'package:get_it/get_it.dart';
import 'package:tdd_tutorial/src/authentication/data/data_sources/authentication_remote_data_src.dart';
import 'package:tdd_tutorial/src/authentication/data/data_sources/authentication_remote_data_src_impl.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/auth_repo_impl.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/use_cases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  // Bloc
  sl.registerFactory(() =>
      AuthenticationCubit(createUserUseCase: sl(), getUsersUseCase: sl()));
  // Use cases
  sl.registerLazySingleton(() => CreateUserUseCase(authenticationRepo: sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(authenticationRepo: sl()));
  // Repository
  sl.registerLazySingleton<AuthenticationRepo>(() => AuthenticationRepositoryImpl(remoteDataSource: sl()));
  // Data sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthRemoteDataSrcImpl(sl()));
  // External
  sl.registerLazySingleton( http.Client.new);

}
