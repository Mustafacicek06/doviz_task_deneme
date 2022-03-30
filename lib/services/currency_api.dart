import 'package:dio/dio.dart';
import 'package:doviz_task/model/currency_model.dart';
import 'package:doviz_task/services/auth_base.dart';
import 'package:flutter/cupertino.dart';

class CurrencyApi extends AuthBase {
  final String _currencyApi =
      "https://free.currconv.com/api/v7/convert?q=USD_TRY,EUR_TRY&compact=ultra&apiKey=26cb9ffd85f9bee9c208";

  @override
  Future<DovizModel?> getCurrency() async {
    var response = await Dio().get(_currencyApi);
    if (response.statusCode == 200) {
      return DovizModel.fromJson(response.data);
    } else {
      debugPrint('${response.statusCode} : ${response.data.toString()}');
      throw UnimplementedError();
    }
  }
}
