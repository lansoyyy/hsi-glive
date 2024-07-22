import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/models/app/FollowingModel.dart';

class TopBarFFWidget extends StatelessWidget {
  // final PostModel postModel;
  final FollowingModel postModel;

  const TopBarFFWidget({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.h,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: postModel.isLike == true ? AppColors.liveBackgroundColor : Colors.white,
                            )),
                        child: CircleAvatar(backgroundImage: NetworkImage(postModel.author.profilePicture.toString()), radius: 24.r),
                      ),
                      postModel.isLike == true
                          ? Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.liveBackgroundColor,
                                ),
                                child: Center(
                                    child: Text(
                                  "Live",
                                  style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                )),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ).paddingOnly(right: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postModel.author.firstName.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(
                              offset: const Offset(0.1, 0.1),
                              blurRadius: 1.0,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                        ),
                      ),
                      Text("140k Followers",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                offset: const Offset(0.1, 0.1),
                                blurRadius: 1.0,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                          )),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.search, color: Colors.white, size: 30.r).paddingOnly(right: 8.w),
                Icon(Icons.notifications_on_outlined, color: Colors.white, size: 30.r),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
