import 'package:fit_bowl_2/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/category_remote_data_source.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/product_remote_data_source.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/remote_authentication_data_source.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/sale_remote_data_source.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/supplement_remote_data_source.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/wishlist_remote_data_source.dart';
import 'package:fit_bowl_2/data/repository/category_repository_impl.dart';
import 'package:fit_bowl_2/data/repository/product_repository_impl.dart';
import 'package:fit_bowl_2/data/repository/sale_repository_impl.dart';
import 'package:fit_bowl_2/data/repository/supplement_repositorry_impl.dart';
import 'package:fit_bowl_2/data/repository/user_repository_impl.dart';
import 'package:fit_bowl_2/data/repository/wishlist_repository_impl.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';
import 'package:fit_bowl_2/domain/repository/category_repository.dart';
import 'package:fit_bowl_2/domain/repository/product_repository.dart';
import 'package:fit_bowl_2/domain/repository/sales_repository.dart';
import 'package:fit_bowl_2/domain/repository/supplement_repository.dart';
import 'package:fit_bowl_2/domain/repository/wishlist_repository.dart';
import 'package:fit_bowl_2/domain/usecases/categoryusecase/get_all_categorys_use_case.dart';
import 'package:fit_bowl_2/domain/usecases/categoryusecase/get_categorybyid_use_case.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_all_products_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_product_bycategory.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_productbyid_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_sorted_product_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/create_sale_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/delete_sale_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/get_selbyid_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/update_sale_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/supplementusecase/get_supplementbyid_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/create_account_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/forget_password_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/get_user_by_id_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/login_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/reset_password_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/update_password_usercase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/update_user_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/userusecase/verify_otp_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/wishlistusecase/create_wishlistusecase.dart';
import 'package:fit_bowl_2/domain/usecases/wishlistusecase/get_wishlisitbyid_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/wishlistusecase/remove_product_wishlist_usecse.dart';
import 'package:fit_bowl_2/domain/usecases/wishlistusecase/update_wishlist_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* repositories */
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(categoryRemoteDataSource: sl()));

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productRemoteDataSource: sl()));

  sl.registerLazySingleton<SupplementRepository>(
      () => SupplementRepositoryImpl(supplementRemoteDataSource: sl()));
  sl.registerLazySingleton<WishlistRepository>(
      () => WishlistRepositoryImpl(wishlistRemoteDataSource: sl()));

  sl.registerLazySingleton<SalesRepository>(
      () => SaleRepositoryImpl(saleRemoteDataSource: sl()));

  // /* data sources */
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<SupplementRemoteDataSource>(
    () => SupplementRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<SaleRemoteDataSource>(
    () => SaleRemoteDataSourceImpl(),
  );

  // sl.registerLazySingleton<CartRemoteDataSource>(
  //     () => CartRemoteDataSourceImpl());
  sl.registerLazySingleton<WishlistRemoteDataSource>(
      () => WishlistRemoteDataSourceImpl());

  /* usecases */
  //authentication//
  sl.registerLazySingleton(() => CreateAccountUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => OTPVerificationUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => GetUserByIdUsecase(sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePasswordUsercase(sl()));

  //categorys//
  sl.registerLazySingleton(() => GetAllCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoryByIdUseCase(sl()));

  //Product//
  sl.registerLazySingleton(() => GetAllProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetProductByIdUseCase(sl()));
  sl.registerLazySingleton(() => GetSortedProductsUseCase(sl()));

  //supp//
  sl.registerLazySingleton(() => GetSupplementByIdUseCase(sl()));

  //wishlist//
  sl.registerLazySingleton(() => CreateWishListUseCase(sl()));
  sl.registerLazySingleton(() => GetWishListByIdUseCase(sl()));
  sl.registerLazySingleton(() => RemoveProductWishlistUsecse(sl()));
  sl.registerLazySingleton(() => UpdateWishListUseCase(sl()));

  //sales//
  sl.registerLazySingleton(() => CreateSaleUseCase(sl()));
  sl.registerLazySingleton(() => DeleteSaleUseCase(sl()));
  sl.registerLazySingleton(() => GetSaleByIdUseCase(sl()));
  sl.registerLazySingleton(() => UpdateSaleUseCase(sl()));
}
