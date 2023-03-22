import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import '../../../../core/base/model/base_state.dart';
import '../../../../core/init/theme/color_manager.dart';
import '../../../controllers/home_detail_controller.dart';

class HomeDetailPage extends GetView<HomeDetailController> {
  final String? imageUrl;
  const HomeDetailPage(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height,
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            GetBuilder<HomeDetailController>(
              init: HomeDetailController(),
              builder: (c) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Platform.isIOS || Platform.isAndroid
                          ? Container(
                              padding: EdgeInsets.all(Utility.dynamicWidthPixel(10)),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.instance.primary,
                              ),
                              child: InkWell(
                                onTap: () {
                                  c.downloadImageForBoth(imageUrl!);
                                },
                                child: Icon(
                                  Icons.download,
                                  size: Utility.dynamicWidthPixel(26),
                                  color: ColorManager.instance.white.withOpacity(0.81),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Platform.isAndroid
                          ? Padding(
                              padding: EdgeInsets.only(left: 20.0.w),
                              child: Container(
                                padding: EdgeInsets.all(Utility.dynamicWidthPixel(10)),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorManager.instance.primary,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    c.setWallpaperForAndroid(WallpaperManagerFlutter.BOTH_SCREENS, imageUrl!);
                                  },
                                  child: Icon(
                                    Icons.wallpaper,
                                    size: Utility.dynamicWidthPixel(26),
                                    color: ColorManager.instance.white.withOpacity(0.81),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
