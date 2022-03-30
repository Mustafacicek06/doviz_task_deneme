import 'package:doviz_task/model/currency_model.dart';

abstract class AuthBase {
  Future<DovizModel?> getCurrency();
}
