import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/constants/assets.dart';
import 'package:glive/modules/login/login_view.dart';
import 'package:glive/routes.dart';
import 'package:glive/utils/commonFunctions.dart';
import 'package:glive/utils/globalVariables.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:simple_shadow/simple_shadow.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/new_bg.png',
            ),
          ),
        ),
        child: Center(
          child: Image.asset(
            height: 186,
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}
