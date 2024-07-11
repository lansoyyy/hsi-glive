import 'package:flutter/material.dart';
import 'package:glive/utils/CallbackModel.dart';
import 'package:glive/utils/GlobalVariables.dart';

class LoadingUtil {
  static bool isLoadingShown = false;

  static LoadingController controller = LoadingController();

  static Widget widget = PopScope(
    canPop: false,
    child: Container(
      height: heightScreen(),
      width: widthScreen(),
      child: const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );

  static void show(BuildContext context) {
    if (!isLoadingShown) {
      showDialog(
        context: context,
        barrierDismissible: false, // Dialog can be dismissed by tapping outside
        builder: (BuildContext context) {
          return widget;
        },
      );
    }
    isLoadingShown = true;
  }

  static void showText(BuildContext context, String text) {
    if (!isLoadingShown) {
      showDialog(
        context: context,
        barrierDismissible: false, // Dialog can be dismissed by tapping outside
        builder: (BuildContext context) {
          return LoadingWidget(controller: controller);
        },
      );
      Future.delayed(Duration(milliseconds: 50), () {
        controller.update(text);
      });
    }
    isLoadingShown = true;
  }

  static void hide(BuildContext context) {
    if (isLoadingShown) {
      Navigator.pop(context);
    }
    isLoadingShown = false;
  }
}

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key, required this.controller});

  final LoadingController controller;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  String loadingText = "";

  @override
  void initState() {
    widget.controller
        .onUpdate(CallbackModel(id: "loading-widget", callback: onUpdate));
    super.initState();
  }

  void onUpdate(dynamic d) {
    String text = d as String;
    if (!mounted) {
      return;
    }
    setState(() {
      loadingText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: heightScreen(),
          width: widthScreen(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                loadingText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingController extends ChangeNotifier {
  List<CallbackModel> updateFunctions = [];

  void update(String text) {
    for (var cb in updateFunctions) {
      cb.callback(text);
    }
  }

  void onUpdate(CallbackModel cb) {
    updateFunctions = updateFunctions.where((el) => el.id != cb.id).toList()
      ..add(cb);
  }
}
