import 'package:doviz_task/repository/currency_repository.dart';
import 'package:doviz_task/services/currency_api.dart';
import 'package:doviz_task/viewmodel/currency_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => CurrencyApi());
  locator.registerLazySingleton(() => CurrencyRepository());
}
