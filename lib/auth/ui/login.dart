import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lab_11/auth/provider/login_provider.dart';
import 'package:lab_11/base/base_provider.dart';
import 'package:lab_11/shared/theme.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProvider<LoginProvider>(
      model: LoginProvider(),
      onReady: (value) async => await value.init(context),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusNode().unfocus();
          },
          child: Scaffold(
            body: Stack(
              children: [
                // Background dark blue container
                Container(
                  width: model.size!.width,
                  height: model.size!.height * 0.45,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                // Form field container
                Container(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  margin: EdgeInsets.only(
                      left: model.size!.width * 0.1,
                      top: model.size!.height * 0.3),
                  width: model.size!.width * 0.8,
                  height: model.size!.height * 0.3,
                  decoration: BoxDecoration(
                      color: AppColors.backColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 1,
                            color: AppColors.primaryColor)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 6),
                      Text(
                        "Вход",
                        style: TextStyle(
                            color: AppColors.darkGrayColor, fontSize: 16),
                      ),
                      Spacer(),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: model.loginCtrl,
                        inputFormatters: [model.loginMasked],
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          labelStyle: TextStyle(color: AppColors.primaryColor),
                          label: Text("Номер"),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: model.passwordCtrl,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          labelStyle: TextStyle(color: AppColors.primaryColor),
                          label: Text("Пароль"),
                        ),
                      ),
                      Spacer(
                        flex: 3,
                      )
                    ],
                  ),
                ),
                // Send Button Container
                Container(
                  width: model.size!.width,
                  margin: EdgeInsets.only(
                      left: model.size!.width * 0.25,
                      right: model.size!.width * 0.25,
                      top: model.size!.height * 0.57),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          //TODO send login service
                          await model.login(context);
                        },
                        child: Container(
                          width: model.size!.width * 0.5,
                          child: Text(
                            "Oтправить",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 1),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Забыли пароль?",
                            style: TextStyle(color: AppColors.primaryColor),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
