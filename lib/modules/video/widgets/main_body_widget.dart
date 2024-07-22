import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/models/app/ForYouModel.dart';

class MainBodyWidget extends StatelessWidget {
  // final PostModel postModel;
  final ForYouModel postModel;

  const MainBodyWidget({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100.h),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        postModel.title, //   "Liveeeee na!!! ✨❤️",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        postModel.tags.map((tag) => '#$tag').join(', '),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ).paddingOnly(bottom: 8.h),
                      Container(
                        color: AppColors.lightGreyColor.withOpacity(0.5),
                        width: 180.w,
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        child: Row(
                          children: [
                            Icon(Icons.queue_music, size: 24.r, color: Colors.white).paddingOnly(right: 8.w),
                            Text(
                              "Original Soundtrack",
                              style: TextStyle(fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ).paddingOnly(bottom: 12.h),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.favorite, size: 40.r, color: postModel.isLike == true ? Colors.red : Colors.red),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          postModel.likes.toString(),
                          style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ).paddingOnly(bottom: 16.h),
                    Column(
                      children: [
                        InkWell(
                          child: Icon(Icons.wechat_rounded, size: 40.r, color: Colors.white),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          postModel.comments.toString(),
                          style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ).paddingOnly(bottom: 16.h),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.card_giftcard, size: 40.r, color: AppColors.giftGradStartColor),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          "0", //postModel.giftCount,
                          style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Dm sans"),
                        )
                      ],
                    ).paddingOnly(bottom: 16.h),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.reply_sharp, size: 40.r, color: Colors.white),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          postModel.shares.toString(),
                          style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ).paddingOnly(bottom: 16.h),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.more_horiz,
                            size: 40.r,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ).paddingOnly(bottom: 12.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
