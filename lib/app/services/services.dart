import 'package:flutter/material.dart';
import 'package:wallpaper_app/app/models/search_result_model.dart';

import '../../core/init/network/network_manager.dart';
import '../models/wallpaper_images_model.dart';

class Services {
  final BuildContext? context;
  Services({this.context});

  Future<WallpaperImagesModel> wallpaperImages() async {
    return await NetworkManager.instance.get<WallpaperImagesModel>(
      path: "/v1/curated?per_page=80",
      model: WallpaperImagesModel(),
      context: context,
    );
  }

  Future<SearchResultModel> searchResultWallpaperImages(String searchKey) async {
    return await NetworkManager.instance.get<SearchResultModel>(
      path: "/v1/search?query=$searchKey&per_page=80",
      model: SearchResultModel(),
      context: context,
    );
  }


  Future<WallpaperImagesModel> loadMoreWallpaperImages(String page) async {
    return await NetworkManager.instance.get<WallpaperImagesModel>(
      path: "/v1/curated?per_page=80&page=$page",
      model: WallpaperImagesModel(),
      context: context,
    );
  }

  Future<SearchResultModel> loadMoreWallpaperImagesAfterSearch(String page, String text) async {
    return await NetworkManager.instance.get<SearchResultModel>(
      path: "/v1/search?query=$text&per_page=$page",
     
      model: SearchResultModel(),
      context: context,
    );
  }
 
}
