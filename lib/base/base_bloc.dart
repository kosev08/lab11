import 'package:flutter/material.dart';

class BaseBloc extends ChangeNotifier {
  /// дата для транзакции
  // DateTime toDate = DateTime.now();
  // DateTime fromDate = DateTime.now().subtract(Duration(days: 90));

  /// показываем состояние загрузки
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _onError = false;
  bool get onError => _onError;

  /// показываем состояение и текст ошибки
  String _errorText = "";
  String get errorText => _errorText;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void catchOnError(bool error, String errorText) {
    _onError = error;
    _errorText = errorText;
    notifyListeners();
  }

  // void setToDate(DateTime date) {
  //   toDate = date;
  //   notifyListeners();
  // }

  // void setFromDate(DateTime date) {
  //   print("setFromDate Called");
  //   fromDate = date;
  //   notifyListeners();
  // }
}
