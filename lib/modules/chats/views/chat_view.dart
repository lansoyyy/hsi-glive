import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/widgets/TextWidget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.gradients,
                  stops: const [0.0, 1.0],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      const CircleAvatar(
                        minRadius: 25,
                        maxRadius: 25,
                        backgroundImage: AssetImage(
                          'assets/images/Ellipse 13.png',
                        ),
                      ),
                      SizedBox(
                        width: 15.sp,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            color: Colors.white,
                            text: 'Jean',
                            fontSize: 22.sp,
                          ),
                          TextWidget(
                            color: Colors.grey,
                            text: '1 minute ago',
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 15.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.videocam_sharp,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            const CircleAvatar(
              minRadius: 40,
              maxRadius: 40,
              backgroundImage: AssetImage(
                'assets/images/Ellipse 13.png',
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            TextWidget(
              color: Colors.black,
              text: 'Jean',
              fontSize: 22.sp,
            ),
            TextWidget(
              color: Colors.grey,
              text: '1 minute ago',
              fontSize: 12.sp,
            ),
            SizedBox(
              height: 20.sp,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  100,
                ),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextWidget(
                  color: Colors.grey,
                  text: 'Today',
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            100,
                          ),
                          color: const Color(0XFF05474F)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: TextWidget(
                          color: Colors.white,
                          text: 'Hi Heartty, Thank you for the add!',
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextWidget(
                          color: Colors.grey,
                          text: 'Now',
                          fontSize: 11.sp,
                        ),
                        SizedBox(
                          width: 5.sp,
                        ),
                        const Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      height: 45,
                      width: 325,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.grey,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            TextWidget(
                              color: Colors.grey,
                              text: 'Send Message',
                              fontSize: 12.sp,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 15.sp,
                              ),
                            ),
                            const Icon(
                              Icons.attach_file_outlined,
                              color: Colors.grey,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.sp,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: Color(0XFF05474F),
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class ChatView extends StatefulWidget {
//   const ChatView({super.key});

//   @override
//   State<ChatView> createState() => _ChatViewState();
// }

// class _ChatViewState extends State<ChatView> {
//   late CachedVideoPlayerPlusController? cachedVideoPlayerPlusController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     cachedVideoPlayerPlusController = CachedVideoPlayerPlusController.networkUrl(
//       Uri.parse("http://stream.ksmiguel.com/live/glivetest.m3u8"),
//       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//       invalidateCacheIfOlderThan: const Duration(days: 1),
//     )..initialize().then((value) {
//         cachedVideoPlayerPlusController?.play();
//         cachedVideoPlayerPlusController?.setLooping(true);
//         cachedVideoPlayerPlusController?.setVolume(1);

//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     cachedVideoPlayerPlusController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AppPageBackground(
//         child: CachedVideoPlayerPlus(cachedVideoPlayerPlusController!),
//       ),
//     );
//   }
// }
