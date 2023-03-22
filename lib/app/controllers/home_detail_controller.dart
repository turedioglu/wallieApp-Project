import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:wallpaper_app/core/init/theme/color_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class HomeDetailController extends GetxController {
  Future downloadImageForBoth(String wallpaperUrl) async {
    try {
      var imageId = await ImageDownloader.downloadImage(wallpaperUrl);
      if (imageId == null) {
        return;
      }

      Get.snackbar(
        "Başarılı",
        "Fotoğraf Başarıyla İndirildi",
        colorText: ColorManager.instance.white,
        backgroundColor: ColorManager.instance.primary,
        icon: Icon(Icons.check_circle, color: ColorManager.instance.green),
      );
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future setWallpaperForAndroid(location, String wallpaperUrl) async {
    var file = await DefaultCacheManager().getSingleFile(wallpaperUrl);
    try {
      WallpaperManagerFlutter().setwallpaperfromFile(file, location);
      Get.snackbar(
        "Başarılı",
        "Kilit Ekranı Yapıldı",
        colorText: ColorManager.instance.white,
        backgroundColor: ColorManager.instance.primary,
        icon: Icon(Icons.check_circle, color: ColorManager.instance.green),
      );
    } catch (e) {
      print(e);
    }
  }
}
