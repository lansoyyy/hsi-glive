import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glive/constants/StorageCodes.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/constants/assets.dart';

import 'package:glive/models/database/AdminModel.dart';

import 'package:glive/models/response/LoginResponse.dart';
import 'package:glive/network/ApiEndpoints.dart';
import 'package:glive/network/NetworkProvider.dart';
import 'package:glive/repositories/AdminRepository.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/CommonFunctions.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/LoadingUtil.dart';
import 'package:glive/utils/LocalStorage.dart';
import 'package:glive/utils/syncHelper.dart';
import 'package:glive/utils/ToastHelper.dart';
import 'package:glive/widgets/TouchableOpacity.dart';
import 'package:glive/widgets/AppPasswordInput.dart';
import 'package:glive/widgets/AppTextInput.dart';

import '../../models/parameters/LoginParameter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController usernameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  NetworkProvider networkProvider = NetworkProvider();
  void login() async {
    /*  GlobalVariables.currentUser = AdminModel(
        id: "a0sdf32da",
        firstName: "Kei",
        lastName: "San",
        username: "branch-admin",
        password: "Password!@#1",
        createdAt: DateTime.now().toIso8601String(),
        parentId: "super-admin",
        userType: "super-admin",
        permissions: "1,2,3,4,5",
        fundsId: "",
        syncedAt: "",
        deletedAt: ""); 
    await LocalStorage.save(StorageCodes.isLoggedIn, "true");
    await LocalStorage.save(StorageCodes.currentUser,
        jsonEncode(GlobalVariables.currentUser.toJson()));
    Navigator.pushNamed(context, RouteNames.home); */

    String username = usernameInput.text;
    String password = passwordInput.text;
    if (username.isEmpty) {
      ToastHelper.error("Username is required");
      return;
    }
    if (password.isEmpty) {
      ToastHelper.error("Password is required");
      return;
    }
    LoadingUtil.show(context);
    String response = await networkProvider.post(ApiEndpoints.login,
        body: LoginParameter(username: username, password: password));

    if (response.isNotEmpty) {
      LoginResponse loginResponse =
          LoginResponse.fromJson(jsonDecode(response));

      await LocalStorage.save(
          StorageCodes.token, loginResponse.token.toString());
      await LocalStorage.save(StorageCodes.isLoggedIn, "true");
      GlobalVariables.currentUser = loginResponse.user!;
      GlobalVariables.isUserReady = true;
      await LocalStorage.save(
          StorageCodes.currentUser, jsonEncode(loginResponse.user!.toJson()));
      await AdminRepository.save(GlobalVariables.currentUser);
      await SyncHelper.checkSync();
      Navigator.pushNamedAndRemoveUntil(
        GlobalVariables.navigatorKey.currentContext!,
        RouteNames.home,
        (Route<dynamic> route) => false,
      );
      return;
    }

    LoadingUtil.hide(context);
  }

  @override
  Widget build(BuildContext context) {
    double panelWidth = widthScreen() < 600 ? widthScreen() : 500;

    return Scaffold(
      backgroundColor: AppColors.lightgrey,
      body: SizedBox(
        height: heightScreen(),
        width: widthScreen(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: widthScreen() < 600 ? widthScreen() : 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(widthScreen() < 600 ? 0 : 9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      Assets.icon,
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "QR Project",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlack),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextInput(
                        width: panelWidth - 40,
                        title: "Username",
                        controller: usernameInput,
                        icon: Assets.user),
                    const SizedBox(
                      height: 20,
                    ),
                    AppPasswordInput(
                        width: panelWidth - 40,
                        title: "Password",
                        controller: passwordInput,
                        icon: Assets.lock),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        TouchableOpacity(
                          onTap: () {
                            login();
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                color: AppColors.deepKoamaru,
                                borderRadius: BorderRadius.circular(9)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.asset(
                                  Assets.arrow_right,
                                  height: 30,
                                  width: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
