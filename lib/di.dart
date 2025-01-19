import 'package:fit_bowl_2/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/remote_authentication_data_source.dart';
import 'package:fit_bowl_2/data/repository/user_repository_impl.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/create_account_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/login_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* repositories */
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(sl(), sl()),
  );
  // sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  // sl.registerLazySingleton<WishListRepository>(
  //     () => WishListRepositoryImpl(sl()));

  // /* data sources */
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

  // sl.registerLazySingleton<CartRemoteDataSource>(
  //     () => CartRemoteDataSourceImpl());
  // sl.registerLazySingleton<WishListRemoteDataSource>(
  //     () => WishListRemoteDataSourceImpl());

  /* usecases */
  //authentication//
  sl.registerLazySingleton(() => CreateAccountUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
}
