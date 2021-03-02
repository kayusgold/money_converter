import 'package:money_converter/core/services/api_service.dart';
import 'package:money_converter/core/services/firestore_service.dart';
import 'package:money_converter/core/services/shared_preference_service.dart';
import 'package:money_converter/core/viewmodels/viewmodel.dart';

import 'core/services/authentication_service.dart';
import 'core/viewmodels/home_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  //locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => LoginViewModel());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FireStoreService());
  locator.registerLazySingleton(() => HomeModel());
  locator.registerLazySingleton(() => SignUpViewModel());
  var instance = await SharedPreferencesService.getInstance();
  locator.registerSingleton<SharedPreferencesService>(instance);
  locator.registerLazySingleton(() => APIService());
}
