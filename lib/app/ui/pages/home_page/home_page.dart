import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/app/ui/pages/home_detail_page/homedetail_page.dart';
import '../../../../core/base/model/base_state.dart';
import '../../../../core/init/theme/color_manager.dart';
import '../../../controllers/home_controller.dart';
import '../../global_widgets/w_textformfield.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (c) {
        c.homeScrollController.addListener(
          () {
            if (c.homeScrollController.position.pixels == c.homeScrollController.position.maxScrollExtent) {
              c.loadMoreWallpaperImages();
            }
          },
        );
        c.searchScrollController.addListener(
          () {
            if (c.searchScrollController.position.pixels == c.searchScrollController.position.maxScrollExtent) {
              c.loadMoreWallpaperImagesAfterSearch();
            }
          },
        );
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 35.0.w),
                child: Image.asset(
                  "assets/images/logo-no-background.png",
                  width: 150.w,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0.w, bottom: 10.w, left: 10.w, right: 10.w),
                      child: WTextFormField.instance.widget(
                        style: TextStyle(fontSize: Utility.dynamicTextSize(16), color: ColorManager.instance.primary),
                        context: context,
                        controller: c.searchController,
                        labelText: "Arama Yap",
                        maxLines: 1,
                        minLines: 1,
                        validation: (val) {
                          if (val!.isEmpty) {
                            return "Lütfen bu alanı doldurunuz.";
                          }

                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10.w,
                    ),
                    child: InkWell(
                      onTap: () {
                        c.searchResulImages = [];
                        c.getSearchResultWallpaperImages(c.searchController.text);
                        c.update();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorManager.instance.primary),
                        child: Center(
                          child: Icon(
                            Icons.search,
                            color: ColorManager.instance.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: c.searchResulImages.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          controller: c.searchScrollController,
                          itemCount: c.searchResulImages.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 2,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => HomeDetailPage(c.images[index].src?.large2X));
                              },
                              child: Container(
                                decoration: BoxDecoration(color: ColorManager.instance.white),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: c.searchResulImages[index].src?.tiny ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          })
                      : GridView.builder(
                          shrinkWrap: true,
                          controller: c.homeScrollController,
                          itemCount: c.images.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 2,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => HomeDetailPage(c.images[index].src?.large2X));
                              },
                              child: Container(
                                decoration: BoxDecoration(color: ColorManager.instance.white),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: c.images[index].src?.tiny ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
