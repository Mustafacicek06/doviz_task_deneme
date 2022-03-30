import 'package:doviz_task/locator.dart';
import 'package:doviz_task/model/currency_model.dart';
import 'package:doviz_task/services/auth_base.dart';
import 'package:doviz_task/services/currency_api.dart';

class CurrencyRepository implements AuthBase {
  final CurrencyApi _currencyApi = locator<CurrencyApi>();

  @override
  Future<DovizModel?> getCurrency() async {
    return await _currencyApi.getCurrency();
  }
}
