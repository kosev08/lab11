import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:lab_11/base/base_bloc.dart';
import 'package:lab_11/result.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuickEntryProvider extends BaseBloc {
  Size? size;
  String pincode = "";
  String code = "";
  String codeFromUser = "";
  bool didAuthenticate = false;

  init(BuildContext context) {
    size = MediaQuery.of(context).size;
    getPincode(context);
  }

  Future<void> getPincode(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    code = sharedPreferences.getString(pincode) ?? "";
    print("Kод с памяти: $code");

    if (code != "") {
      fingerAuth(context);
    }
  }

  Future<void> fingerAuth(BuildContext context) async {
    var localAuth = LocalAuthentication();
    didAuthenticate =
        await localAuth.authenticate(localizedReason: 'Please authenticate!)');
    if (didAuthenticate) {
      print("Navigation to MAIN_Page!");
      goToMainPage(context);
    } else {
      print("Что-то не так пошло с фингерпринтом: $didAuthenticate");
    }
  }

  void goToMainPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  onConfirm(BuildContext context, String pin) async {
    if (code == "") {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(pincode, pin);
      goToMainPage(context);
      print('Password saved!');
    } else if (code != "") {
      if (code == pin) {
        print("Pin: $pin");
        print("Code: $code");
        print("Правильный пароль!");
        goToMainPage(context);
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Неправильный пин!",
        );
      }
    }
  }

  onChange(String pin) {
    codeFromUser = pin;
    notifyListeners();
  }
}
