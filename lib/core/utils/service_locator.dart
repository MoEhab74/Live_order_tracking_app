import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:practical_google_maps_example/core/utils/storage_helper.dart';
import 'package:practical_google_maps_example/features/auth/cubit/auth_cubit.dart';
import 'package:practical_google_maps_example/features/auth/repo/auth_repo.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  //Storage Helper

  sl.registerLazySingleton(() => StorageHelper());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => AuthRepo());
  sl.registerLazySingleton(() => AuthCubit());

  // Repos
  // sl.registerLazySingleton(() => AuthRepo(sl<DioHelper>()));
  // sl.registerLazySingleton(() => HomeRepo(sl<DioHelper>()));
  // sl.registerLazySingleton(() => CartRepo(sl<DioHelper>()));

  // Cubit
  // sl.registerFactory(() => AuthCubit(sl<AuthRepo>()));
  // sl.registerFactory(() => ProductCubit(sl<HomeRepo>()));
  // sl.registerFactory(() => CategoriesCubit(sl<HomeRepo>()));
  // sl.registerFactory(() => CartCubit(sl<CartRepo>()));
}
