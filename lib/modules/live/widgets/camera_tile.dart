import 'package:flutter/material.dart';

class CameraTile extends StatelessWidget {
  const CameraTile({
    super.key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  });

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: const Color.fromARGB(255, 244, 201, 244).withOpacity(0.2),
      height: extent,
      child: const Center(
        child: Icon(Icons.chair),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        ),
        //4 Guest Screen
        // Center(
        //   child: Container(
        //     height: 300.sp,
        //     width: double.infinity,
        //     decoration: const BoxDecoration(color: Colors.red),
        //     child: StaggeredGrid.count(
        //       crossAxisCount: 4,
        //       mainAxisSpacing: 3,
        //       crossAxisSpacing: 4,
        //       children: const [
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 3,
        //           mainAxisCellCount: 3.03,
        //           child: Tile(index: 0),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1,
        //           child: Tile(index: 1),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1,
        //           child: Tile(index: 2),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1,
        //           child: Tile(index: 3),
        //         ),
        //       ],
        //     ),
        //   ),
        // ).paddingSymmetric(horizontal: 15.sp),
        //------------------------------------------------//
        //6 Guest Screen
        // Center(
        //   child: Container(
        //     height: 300.sp,
        //     width: double.infinity,
        //     decoration: BoxDecoration(color: Colors.grey.shade400),
        //     child: StaggeredGrid.count(
        //       crossAxisCount: 3,
        //       mainAxisSpacing: 3,
        //       crossAxisSpacing: 3,
        //       children: const [
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 2,
        //           mainAxisCellCount: 1.52,
        //           child: Tile(index: 0),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: .76,
        //           child: Tile(index: 1),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: .76,
        //           child: Tile(index: 2),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 0.76,
        //           child: Tile(index: 3),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 0.76,
        //           child: Tile(index: 4),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 0.76,
        //           child: Tile(index: 5),
        //         ),
        //       ],
        //     ),
        //   ),
        // ).paddingSymmetric(horizontal: 15.sp),
        //------------------------------------------------//
        //9 Guest Screen
        // Center(
        //   child: Container(
        //     height: 300.sp,
        //     width: double.infinity,
        //     decoration: BoxDecoration(color: Colors.grey.shade400),
        //     child: StaggeredGrid.count(
        //       crossAxisCount: 4,
        //       mainAxisSpacing: 3,
        //       crossAxisSpacing: 3,
        //       children: const [
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 2,
        //           mainAxisCellCount: 2.03,
        //           child: Tile(index: 0),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 1),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 2),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 3),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 4),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 5),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 6),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 7),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 8),
        //         ),
        //       ],
        //     ),
        //   ),
        // ).paddingSymmetric(horizontal: 15.sp),
        //------------------------------------------------//
        //12 Guest Screen
        // Center(
        //   child: Container(
        //     height: 300.sp,
        //     width: double.infinity,
        //     decoration: BoxDecoration(color: Colors.grey.shade400),
        //     child: StaggeredGrid.count(
        //       crossAxisCount: 4,
        //       mainAxisSpacing: 4,
        //       crossAxisSpacing: 4,
        //       children: const [
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 0),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 1),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 2),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 3),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 4),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 5),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 6),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 7),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 8),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 9),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 10),
        //         ),
        //         StaggeredGridTile.count(
        //           crossAxisCellCount: 1,
        //           mainAxisCellCount: 1.01,
        //           child: Tile(index: 11),
        //         ),
        //       ],
        //     ),
        //   ),
        // ).paddingSymmetric(horizontal: 15.sp),
      ],
    );
  }
}
