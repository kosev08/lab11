import 'package:flutter/material.dart';
import 'package:lab_11/auth/provider/quick_entry_provider.dart';
import 'package:lab_11/base/base_provider.dart';
import 'package:pin_dot/pin_dot.dart';
import 'package:pin_keyboard/pin_keyboard.dart';

class QuickEntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProvider<QuickEntryProvider>(
      model: QuickEntryProvider(),
      onReady: (value) => value.init(context),
      builder: (context, model, child) {
        return Scaffold(
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Expanded(
                  child: Center(
                      child: model.code == ""
                          ? Text(
                              "Введите код",
                              style: TextStyle(fontSize: 15),
                            )
                          : Text("Быстрый вход"))),
              Expanded(
                flex: 2,
                child: PinDot(
                  size: 17,
                  length: 4,
                  text: model.codeFromUser,
                  activeColor: Color(0xff47536d),
                  borderColor: Color(0xff3f4b66),
                ),
              ),
              Expanded(
                flex: 2,
                child: PinKeyboard(
                  length: 4,
                  enableBiometric: true,
                  iconBiometricColor: Color(0xff47536d),
                  onChange: (pin) {
                    model.onChange(pin);
                  },
                  onConfirm: (pin) async {
                    await model.onConfirm(context, pin);
                  },
                  onBiometric: () async {
                    await model.fingerAuth(context);
                  },
                ),
              )
            ]));
      },
    );
  }
}
