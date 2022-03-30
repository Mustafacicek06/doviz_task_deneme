import 'package:doviz_task/locator.dart';
import 'package:doviz_task/model/currency_model.dart';
import 'package:doviz_task/repository/currency_repository.dart';
import 'package:doviz_task/services/auth_base.dart';
import 'package:flutter/cupertino.dart';

enum ViewState { idle, busy }

class CurrencyViewModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.idle;

  final CurrencyRepository _currencyRepository = locator<CurrencyRepository>();

  DovizModel? _dovizModel;

  DovizModel? get dovizModel => _dovizModel;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;

    notifyListeners();
  }

  CurrencyViewModel() {
    getCurrency();
  }

  @override
  Future<DovizModel?> getCurrency() async {
    try {
      _state = ViewState.busy;
      _dovizModel = await _currencyRepository.getCurrency();
      return _dovizModel;
    } catch (e) {
      debugPrint('viewmodeldeki getcurrency de hata var' + e.toString());
    } finally {
      _state = ViewState.idle;
    }
  }
}
