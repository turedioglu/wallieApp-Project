import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/app/models/search_result_model.dart';
import 'package:wallpaper_app/app/models/wallpaper_images_model.dart';
import '../services/services.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();

  WallpaperImagesModel homeDataModel = WallpaperImagesModel();
  SearchResultModel searchResultModel = SearchResultModel();
  List images = [];
  List searchResulImages = [];
  @override
  void onInit() {
    getWallpaperImages();
    super.onInit();
  }

  getWallpaperImages() async {
    homeDataModel = await Services().wallpaperImages();
    images = homeDataModel.photos as List<dynamic>;
    update();
  }

  getSearchResultWallpaperImages(String searchValue) async {
    searchResultModel = await Services().searchResultWallpaperImages(searchValue);
    searchResulImages = searchResultModel.photos as List<dynamic>;
    update();
  }

  int page = 0;
  loadMoreWallpaperImages() async {
    page = page + 1;
    update();
    homeDataModel = await Services().loadMoreWallpaperImages(page.toString());
    images.addAll(homeDataModel.photos as List<dynamic>);
    update();
  }

  int item = 0;
  loadMoreWallpaperImagesAfterSearch() async {
    item = item + 1;
    update();
    searchResultModel = await Services().loadMoreWallpaperImagesAfterSearch(item.toString(), searchController.text);
    searchResulImages.addAll(searchResultModel.photos as List<dynamic>);
    update();
  }

  ScrollController homeScrollController = ScrollController();
  ScrollController searchScrollController = ScrollController();
}
