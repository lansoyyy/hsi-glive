import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/constants/assets.dart';
import 'package:glive/database/appDatabase.dart';
import 'package:glive/models/app/BalanceModel.dart';
import 'package:glive/models/database/FundModel.dart';
import 'package:glive/repositories/FundRepository.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/AppUtil.dart';
import 'package:glive/utils/CommonFunctions.dart';
import 'package:glive/utils/GlobalVariables.dart';
import 'package:glive/utils/LoadingUtil.dart';
import 'package:glive/utils/LocalStorage.dart';
import 'package:glive/utils/QuickDialog.dart';
import 'package:glive/utils/syncHelper.dart';
import 'package:glive/utils/ToastHelper.dart';
import 'package:glive/widgets/TouchableOpacity.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double totalFunds = 0;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      initWidget();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void initWidget() async {
    LoadingUtil.show(context);
    await Future.wait([SyncHelper.checkSync(), SyncHelper.syncAllUnsynced()]);
    LoadingUtil.hide(context);
    BalanceModel balanceModel =
        await AppUtil.loadBalance(GlobalVariables.currentUser.fundsId);

    log("Balance model: ${balanceModel.funds}");

    try {
      setState(() {
        totalFunds = double.parse(balanceModel.funds.toString());
      });
    } catch (_) {
      log("Error parsing funds");
    }
  }

  void logout() {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1, 0, 0, 0),
      items: <PopupMenuEntry>[
        const PopupMenuItem(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ),
      ],
    ).then((value) async {
      if (value != null) {
        if (value == 'logout') {
          bool willLogout = await QuickDialog.logoutConfirmation(context);
          if (willLogout) {
            await LocalStorage.deleteAll();
            await AppDatabase.reset();

            Navigator.pushNamedAndRemoveUntil(
              GlobalVariables.navigatorKey.currentContext!,
              RouteNames.login,
              (Route<dynamic> route) => false,
            );
          }
        }
      }
    });
  }

  Future addFunds() async {
    String getNewfunds =
        await QuickDialog.getInt(context, "Add Funds", "Add Amount Here", "0");
    if (getNewfunds.isNotEmpty) {
      int newAmount = int.parse(getNewfunds);

      if (newAmount > 0) {
        await FundRepository.create(FundModel(
          id: uid(),
          type: "adjust",
          adminId: GlobalVariables.currentUser.id,
          fundsId: GlobalVariables.currentUser.fundsId,
          amount: newAmount.toString(),
          createdAt: DateTime.now().toIso8601String(),
          syncedAt: "",
          deletedAt: "",
        ));
        initWidget();
      } else {
        ToastHelper.error("Invalid add amount");
      }
    }
  }

  Future subtractFunds() async {
    String getNewfunds = await QuickDialog.getInt(
        context, "Subtract Funds", "Subtract Amount Here", "0");
    if (getNewfunds.isNotEmpty) {
      int newAmount = int.parse(getNewfunds);
      if (newAmount <= totalFunds) {
        await FundRepository.create(FundModel(
          id: uid(),
          type: "adjust",
          amount: "-${newAmount.toString()}",
          adminId: GlobalVariables.currentUser.id,
          fundsId: GlobalVariables.currentUser.fundsId,
          createdAt: DateTime.now().toIso8601String(),
          syncedAt: "",
          deletedAt: "",
        ));
        initWidget();
      } else {
        ToastHelper.error("Invalid subtract amount");
      }
    }
  }

  void showFundsPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adjust Funds'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Add'); // Pop with 'Add' option
                  addFunds();
                },
                child: const Text('Add Funds'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Edit'); // Pop with 'Edit' option
                  subtractFunds();
                },
                child: const Text('Subtract Funds'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!GlobalVariables.isUserReady) {
      return const Center();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: heightScreen(),
        width: widthScreen(),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Hi ${GlobalVariables.currentUser.firstName.toTitleCase()},",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.4)),
                  ),
                  const Spacer(),
                  TouchableOpacity(
                      onTap: () {
                        logout();
                      },
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: Image.asset(
                            Assets.settings,
                            height: 25,
                            width: 25,
                            color: AppColors.black.withOpacity(0.8),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    GlobalVariables.currentUser.fundsId.isNotEmpty
                        ? commaNumber(totalFunds)
                        : isSuperAdmin()
                            ? commaNumber(totalFunds)
                            : "0.00",
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.75)),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "TOTAL BALANCE",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: GlobalVariables.currentUser.id ==
                        GlobalVariables.currentUser.fundsId,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: TouchableOpacity(
                        onTap: () {
                          showFundsPickerDialog();
                        },
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  width: 1,
                                  color: Colors.black.withOpacity(0.8))),
                          child: Center(
                            child: Text(
                              "Adjust",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TouchableOpacity(
                    onTap: () {
                      initWidget();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      color: Colors.transparent,
                      child: Center(
                        child: Image.asset(
                          Assets.refresh,
                          height: 20,
                          width: 20,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "What do you want to do today?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.85)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  homeButton("#D7D5F2", Assets.user_shield, "Admins",
                      "Manage all the admins below you and their scope", () {
                    isSuperAdmin()
                        ? Navigator.pushNamed(context, RouteNames.admins)
                        : Navigator.pushNamed(context, RouteNames.branchAdmin,
                            arguments: {
                                "model": GlobalVariables.currentUser,
                                "path":
                                    "/${GlobalVariables.currentUser.username}/"
                              });
                  }),
                  const SizedBox(
                    width: 20,
                  ),
                  homeButton("#E8F2D0", Assets.digital_id, "Digital IDs",
                      "List of all the registered ID in the system", () {
                    Navigator.pushNamed(context, RouteNames.digitalIds);
                  }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  homeButton("#F1F6F2", Assets.peso, "Cash History",
                      "Tracking of all the disbursement to users", () {
                    Navigator.pushNamed(context, RouteNames.cashHistory);
                  }),
                  const SizedBox(
                    width: 20,
                  ),
                  homeButton("#FAEEC6", Assets.qr, "Disbursement",
                      "Disburse cash to your people using this tool", () async {
                    if (GlobalVariables.currentUser.fundsId.isNotEmpty) {
                      await Navigator.pushNamed(
                          context, RouteNames.disbursementScanner);
                      initWidget();
                    } else {
                      if (GlobalVariables.currentUser.userType ==
                          "super-admin") {
                        ToastHelper.error(
                            "Super admin is not allowed to disburse");
                      } else {
                        ToastHelper.error(
                            "You do not have any connected source to your account");
                      }
                    }
                  }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  homeButton("#C6D5FA", Assets.reports, "Reports",
                      "Generate reports of all events in the application", () {
                    Navigator.pushNamed(context, RouteNames.reports);
                  }),
                  const SizedBox(
                    width: 20,
                  ),
                  homeButton("", "", "", "", () {}),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeButton(String color, String image, String title,
      String description, Function onPress) {
    return Expanded(
      child: TouchableOpacity(
        onTap: () {
          onPress();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: color.isNotEmpty ? HexColor(color) : Colors.transparent),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image.isNotEmpty
                  ? Image.asset(
                      image,
                      color: HexColor("#333431"),
                      height: 30,
                      width: 30,
                    )
                  : const Center(),
              const SizedBox(
                height: 15,
              ),
              Text(
                title,
                style: TextStyle(
                    color: HexColor("#333431"),
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                description,
                style: TextStyle(
                    color: HexColor("#333431"),
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
