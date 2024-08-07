import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/widgets/TextWidget.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    opacity: 0.6,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/image 12.png',
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Go live!!!',
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                      TextWidget(
                        align: TextAlign.start,
                        text: 'June 22,\n2024',
                        fontSize: 8.sp,
                        color: Colors.white60,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
