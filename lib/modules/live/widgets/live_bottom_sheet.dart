import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LiveBottomSheet {
  static void showPrivacySettings(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 16.sp),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.close, color: Colors.transparent, size: 20.r),
                Text("Privacy Settings", style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close, color: Colors.black, size: 24.r)),
              ],
            ).paddingOnly(bottom: 4.h, left: 8.sp, right: 8.sp),
            Divider(color: Colors.grey.shade300),
            Padding(
              padding: EdgeInsets.only(top: 16.sp, left: 8.sp),
              child: Text("Who can watch this", style: TextStyle(fontSize: 12.sp, color: const Color(0xFF737373), fontWeight: FontWeight.w400)),
            ),
            ListTile(
              title: Text("Everyone", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
              contentPadding: EdgeInsets.zero,
              dense: true,
              trailing: Radio(
                value: 'Everyone',
                groupValue: 'Everyone',
                activeColor: const Color(0xFF0A9AAA),
                onChanged: (value) {},
              ),
            ).paddingOnly(left: 8.sp),
            Divider(color: Colors.grey.shade300),
            ListTile(
              title: Text("Only me", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
              contentPadding: EdgeInsets.zero,
              dense: true,
              trailing: Radio(
                value: 'Only me',
                groupValue: 'Everyone',
                activeColor: const Color(0xFF0A9AAA),
                onChanged: (value) {},
              ),
            ).paddingOnly(left: 8.sp),
            Divider(color: Colors.grey.shade300),
            SwitchListTile(
              title: Text("Allow Comments", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
              value: true,
              contentPadding: EdgeInsets.zero,
              activeColor: const Color(0xFFFFFFFF),
              activeTrackColor: const Color(0xFF0A9AAA),
              onChanged: (bool value) {},
            ).paddingOnly(left: 8.sp),
            SizedBox(height: 24.sp)
          ],
        ),
      ),
      isDismissible: false,
    );
  }

  static void showStreamQualitySettings(BuildContext context) {
    Get.bottomSheet(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 16.sp),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.close, color: Colors.transparent, size: 20.r),
                  Text("Stream Quality Settings", style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.close, color: Colors.black, size: 24.r)),
                ],
              ).paddingOnly(bottom: 4.h, left: 8.sp, right: 8.sp),
              Divider(color: Colors.grey.shade300),
              ListTile(
                title: Text("Auto", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                contentPadding: EdgeInsets.zero,
                dense: true,
                trailing: Radio(
                  value: 'Auto',
                  groupValue: 'Auto',
                  activeColor: const Color(0xFF0A9AAA),
                  onChanged: (value) {},
                ),
              ).paddingOnly(left: 8.sp),
              Divider(color: Colors.grey.shade300),
              ListTile(
                title: Text("360p", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                contentPadding: EdgeInsets.zero,
                dense: true,
                trailing: Radio(
                  value: '360p',
                  groupValue: 'Auto',
                  activeColor: const Color(0xFF0A9AAA),
                  onChanged: (value) {},
                ),
              ).paddingOnly(left: 8.sp),
              Divider(color: Colors.grey.shade300),
              ListTile(
                title: Text("720p", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                contentPadding: EdgeInsets.zero,
                dense: true,
                trailing: Radio(
                  value: '720p',
                  groupValue: 'Auto',
                  activeColor: const Color(0xFF0A9AAA),
                  onChanged: (value) {},
                ),
              ).paddingOnly(left: 8.sp),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 24.sp)
            ],
          ),
        ),
        isDismissible: false);
  }

  static void showAddSoundsBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height, // Full screen height
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("This is a Add sound BottomSheet"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true, // Allows the BottomSheet to take the full height of the screen
    );
  }

  static void showAddHashtagBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height, // Full screen height
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("This is a Add Hashtags BottomSheet"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true, // Allows the BottomSheet to take the full height of the screen
    );
  }

  static void showAddDescriptionBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height, // Full screen height
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("This is Add Description BottomSheet"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true, // Allows the BottomSheet to take the full height of the screen
    );
  }
}
