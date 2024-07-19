import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/models/app/LiveStreamState.dart';
import 'package:glive/modules/live/controller/camera_live_controller.dart';
import 'package:glive/modules/live/controller/video_live_controller.dart';
import 'package:glive/modules/live/views/video_preview_view.dart';
import 'package:glive/modules/live/widgets/camera_tile.dart';

class MultiLiveWidget extends StatelessWidget {
  // final CameraController cameraController;
  final LiveStreamTextureMixin textureManager;
  final LiveStreamState state;
  final VideoLiveController videoLiveController = Get.find();

  // MultiLiveWidget({super.key, required this.cameraController});
  MultiLiveWidget({super.key, required this.textureManager, required this.state});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 300.sp,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.centerLeft,
          begin: Alignment.centerRight,
          colors: AppColors.gradiants2,
        ),
      ),
      child: Obx(
        () => videoLiveController.multiLiveCounte.value == 4
            ? StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 3,
                crossAxisSpacing: 4,
                children: [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 3.03,
                    // child: CameraPreview(cameraController),
                    child: VideoPreviewView(textureManager: textureManager, state: state),
                  ),
                  const StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: CameraTile(index: 1),
                  ),
                  const StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: CameraTile(index: 2),
                  ),
                  const StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: CameraTile(index: 3),
                  ),
                ],
              )
            : videoLiveController.multiLiveCounte.value == 6
                ? StaggeredGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 1.52,
                        // child: CameraPreview(cameraController),
                        child: VideoPreviewView(textureManager: textureManager, state: state),
                      ),
                      const StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: .76,
                        child: CameraTile(index: 1),
                      ),
                      const StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: .76,
                        child: CameraTile(index: 2),
                      ),
                      const StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 0.76,
                        child: CameraTile(index: 3),
                      ),
                      const StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 0.76,
                        child: CameraTile(index: 4),
                      ),
                      const StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 0.76,
                        child: CameraTile(index: 5),
                      ),
                    ],
                  )
                : videoLiveController.multiLiveCounte.value == 9
                    ? StaggeredGrid.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3,
                        children: [
                          StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 2.03,
                            // child: CameraPreview(cameraController),
                            child: VideoPreviewView(textureManager: textureManager, state: state),
                          ),
                          const StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.01,
                            child: CameraTile(index: 1),
                          ),
                          const StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.01,
                            child: CameraTile(index: 2),
                          ),
                          const StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.01,
                            child: CameraTile(index: 3),
                          ),
                          const StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.01,
                            child: CameraTile(index: 4),
                          ),
                          const StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.01,
                            child: CameraTile(index: 5),
                          ),
                          const StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.01,
                            child: CameraTile(index: 6),
                          ),
                          const StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.01,
                            child: CameraTile(index: 7),
                          ),
                          const StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.01,
                            child: CameraTile(index: 8),
                          ),
                        ],
                      )
                    : videoLiveController.multiLiveCounte.value == 12
                        ? StaggeredGrid.count(
                            crossAxisCount: 4,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 4,
                            children: [
                              StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                // child: CameraPreview(cameraController),
                                child: VideoPreviewView(textureManager: textureManager, state: state),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 1),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 2),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 3),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 4),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 5),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 6),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 7),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 8),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 9),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 10),
                              ),
                              const StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 1.01,
                                child: CameraTile(index: 11),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
      ),
    ).paddingSymmetric(horizontal: 15.sp));
  }
}
