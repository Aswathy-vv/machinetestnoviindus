import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:machinetestnoviindus/repo/homerepo.dart';

class HomeProvider extends ChangeNotifier {
  Map<String, dynamic>? bannerData;
  Map<String, dynamic>? categoryData;

  bool isBannerLoading = false;
  bool isCategoryLoading = false;

  Future<void> fetchBannerData() async {
    isBannerLoading = true;
    notifyListeners();

    try {
      final response = await HomeRepo().homedata();
      bannerData = response;
      log("Banner data: $response");
    } catch (e) {
      log("Error fetching banner data: $e");
    }

    isBannerLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategoryData() async {
    isCategoryLoading = true;
    notifyListeners();

    try {
      final response = await HomeRepo().categorylist();
      categoryData = response;
      log("Category data: $response");
    } catch (e) {
      log("Error fetching category data: $e");
    }

    isCategoryLoading = false;
    notifyListeners();
  }

  /// List of categories from bannerData
  List get bannerCategories {
    if (bannerData != null && bannerData!["categories"] != null) {
      return bannerData!["categories"];
    }
    return [];
  }

  /// Category dict list from categoryData
  List get categoryTabs {
    if (categoryData != null && categoryData!["category_dict"] != null) {
      return categoryData!["category_dict"];
    }
    return [];
  }

  /// Results list from categoryData
  List get results {
    if (categoryData != null && categoryData!["results"] != null) {
      return categoryData!["results"];
    }
    return [];
  }
}
