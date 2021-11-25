import 'package:flutter/material.dart';
import 'package:lab_11/auth/ui/quick_entry.dart';
import 'package:lab_11/base/base_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import '../../service.dart';

class LoginProvider extends BaseBloc {
  TextEditingController loginCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  AuthService authService = AuthService();

  Size? size;

  var loginMasked = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  init(BuildContext context) async {
    size = MediaQuery.of(context).size;
  }

  login(BuildContext context) async {
    print(loginMasked.getUnmaskedText());
    print(passwordCtrl.text);
    var headers = {'Content-language': 'ru'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://7food.kz/api/auth/login?phone=${loginMasked.getUnmaskedText()}&password=${passwordCtrl.text}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("SUCCESS");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => QuickEntryScreen()));
    } else {
      print(response.reasonPhrase);
    }
  }
}
