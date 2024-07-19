import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/widgets/TextWidget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 80.sp,
          height: 80.sp,
        ),
        SizedBox(
          width: 5.sp,
        ),
        TextWidget(
          text: 'GoodVibes Live',
          fontSize: 15.sp,
          color: Colors.white,
        ),
        Expanded(
          child: SizedBox(
            width: 10.sp,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_active_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
