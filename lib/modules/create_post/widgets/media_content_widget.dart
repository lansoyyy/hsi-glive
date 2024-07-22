import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';

class MediaContentWidget extends StatelessWidget {
  MediaContentWidget({super.key});
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80.sp,
      left: 10.sp,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              controller.isDropdownOpen.value = !controller.isDropdownOpen.value;
            },
            child: Container(
              width: 150.sp,
              padding: EdgeInsets.only(top: 8.0.sp, bottom: 8.sp, left: 8.sp),
              decoration: BoxDecoration(
                  color: const Color(0xFF000000).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white70, width: 0.3)),
              child: Obx(
                () => controller.selectedContentName.value.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Content Category',
                            style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 4.w),
                          Icon(Icons.arrow_drop_down, color: Colors.white, size: 20.r),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(controller.selectedContentIcon.value, height: 20.sp, width: 20.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              "${controller.selectedContentName.value} Content",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 4.sp),
              ),
            ),
          ),
          Obx(() => controller.isDropdownOpen.value
              ? Container(
                  width: 150.sp,
                  padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                  decoration: BoxDecoration(
                      color: const Color(0xFF000000).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white70, width: 0.3)),
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: controller.mergedIconInterestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            controller.selectedContentName.value = controller.mergedIconInterestList[index]['name'];
                            controller.selectedContentID.value = controller.mergedIconInterestList[index]['id'];
                            controller.selectedContentIcon.value = controller.mergedIconInterestList[index]['icon'];
                            // controller.isDropdownOpen.value = false;
                            controller.onPostsAddContent(index);
                          },
                          child: Container(
                            width: 145.sp,
                            padding: EdgeInsets.symmetric(vertical: 6.0.sp, horizontal: 2.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(controller.mergedIconInterestList[index]["icon"], height: 20.sp, width: 20.sp),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    controller.mergedIconInterestList[index]['name'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
