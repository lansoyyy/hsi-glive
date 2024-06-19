import 'package:flutter/material.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/constants/assets.dart';
import 'package:glive/utils/QuickDialog.dart';
import 'package:glive/widgets/TouchableOpacity.dart';

Widget backButton(Function onPress) {
  return TouchableOpacity(
    onTap: () {
      onPress();
    },
    child: Container(
      color: Colors.transparent,
      height: 50,
      width: 50,
      child: Center(
        child: Image.asset(
          Assets.back,
          color: Colors.black.withOpacity(0.75),
          height: 25,
          width: 25,
        ),
      ),
    ),
  );
}

Widget refreshButton(Function onPress) {
  return TouchableOpacity(
    onTap: () {
      onPress();
    },
    child: Container(
      color: Colors.transparent,
      height: 50,
      width: 50,
      child: Center(
        child: Image.asset(
          Assets.refresh,
          color: Colors.black.withOpacity(0.75),
          height: 25,
          width: 25,
        ),
      ),
    ),
  );
}

Widget saveButton(Function onPress) {
  return TouchableOpacity(
      onTap: () {
        onPress();
      },
      child: Container(
        height: 60,
        width: 300,
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: const Center(
          child: Text(
            "SAVE",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ));
}

Widget deleteButton(BuildContext context, Function onDelete) {
  return TouchableOpacity(
      onTap: () async {
        bool willDelete = await QuickDialog.deleteConfirmation(context);
        if (willDelete) {
          onDelete();
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ));
}

Widget deleteButtonInDirect(BuildContext context, Function onPress) {
  return TouchableOpacity(
      onTap: () async {
        onPress();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ));
}

Widget editButton(BuildContext context, Function onPress) {
  return TouchableOpacity(
      onTap: () async {
        onPress();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ));
}

Widget printButton(BuildContext context, Function onPress) {
  return TouchableOpacity(
      onTap: () async {
        onPress();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.deepKoamaru,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(
          child: Icon(
            Icons.print,
            color: Colors.white,
          ),
        ),
      ));
}
