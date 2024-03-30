import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:road_mate_shopping_app/model/brand_list_model.dart';
import 'package:road_mate_shopping_app/model/category_list_model.dart';
import 'package:road_mate_shopping_app/model/home_list_model.dart';
import 'package:road_mate_shopping_app/model/subcategory_list_model.dart';
import 'package:road_mate_shopping_app/rest_api/home_page/home_page_service.dart';
import 'package:road_mate_shopping_app/screen/filter_modal_content.dart';
import 'package:road_mate_shopping_app/utils/res/common_widget.dart';
import 'package:road_mate_shopping_app/utils/res/service_locator_setup.dart';
import 'package:stacked/stacked.dart';

class HomeScreenViewModel extends BaseViewModel {
  HomePageService homePageService = locator<HomePageService>();
  CategoryListData? categoryListData;
  BrandListData? brandListData;
  SubCategoryListData? subCategoryListData;
  HomeListModel? homeListModel;
  List<Categorylist> categoryList = [
    Categorylist(
      id: 22,
      categoryName: "All Products",
      catId: 0,
      image: null,
      status: 1,
    ),
  ];
  int page = 1;
  int id = 22;
  ScrollController scrollController = ScrollController();
  Categorylist? selectedCategoryList;
  Subcategorylist? selectedSubcategoryList;
  bool noInternet = false;
  bool timeout = false;
  bool filterApplied = false;
  bool dataLoading = false;
  bool isPaging = false;
  bool showCancel = false;
  TextEditingController textEditingController = TextEditingController();

  bool subCategoryLoading = false;

  void init() async {
    scrollController.addListener(() {
      if (scrollController.offset >
          (scrollController.position.maxScrollExtent - 2000)) {
        scrollListener();
      }
    });
    textEditingController.addListener(() {
      if (textEditingController.text.isNotEmpty == false) {
        showCancel = false;
        scrollListener();
        page = 1;
      } else {
        searchOnChange(textEditingController.text);
      }
    });
    selectedCategoryList = categoryList.first;
    setBusy(true);
    await categoryListLoad();
    setBusy(false);
    await homePageLoad();
  }

  void scrollListener() {
    if (!isPaging) {
      isPaging = true;
      notifyListeners();
      page++;
      if (showCancel) {
        searchLoading(textEditingController.text);
      } else if (filterApplied) {
        brandFilterLoad();
      } else {
        homePageLoad();
      }
    }
  }

  Future<void> homePageLoad() async {
    try {
      isPaging = true;
      dataLoading = true;
      filterApplied = false;
      notifyListeners();
      HomeListModel? response =
          await homePageService.categoryProductList(id, page);
      if (response != null) {
        if (response.error != true) {
          if (page == 1) {
            homeListModel = response;
          } else {
            homeListModel?.productlist?.addAll(response.productlist ?? []);
          }
        } else {
          showBotToast(response.message);
        }
      }
      dataLoading = false;
      isPaging = false;
      notifyListeners();
    } catch (e, s) {
      dataLoading = false;
      isPaging = false;
      notifyListeners();
      if (e is SocketException) {
        noInternet = true;
      } else if (e is TimeoutException) {
        timeout = true;
      } else {
        print(e);
        print(s);
      }
    }
    notifyListeners();
  }

  Future<void> onClearTap() async {
    showCancel = false;
    page = 1;
  }

  Future<void> searchOnChange(String value) async {
    showCancel = true;
    page = 1;
    await searchLoading(value);
  }

  Future<void> searchLoading(String value) async {
    try {
      dataLoading = true;
      notifyListeners();
      HomeListModel? response =
          await homePageService.searchProduct(value, page);
      if (response != null) {
        if (response.error != true) {
          if (page == 1) {
            homeListModel = response;
          } else {
            homeListModel?.productlist?.addAll(response.productlist ?? []);
          }
        } else {
          showBotToast(response.message);
        }
      }
      dataLoading = false;
      isPaging = false;
      notifyListeners();
    } catch (e, s) {
      if (e is SocketException) {
        noInternet = true;
      } else if (e is TimeoutException) {
        timeout = true;
      } else {
        print(e);
        print(s);
      }
    }
    notifyListeners();
  }

  Future<void> selectCategory(int index) async {
    selectedCategoryList = categoryList[index];
    id = categoryList[index].id!;
    if (scrollController.hasClients &&
        scrollController.position.maxScrollExtent > 0) {
      scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the curve as needed
      );
    }
    page = 1;
    filterApplied = false;
    selectedSubcategoryList = null;
    notifyListeners();
    await subcategoryList();
    await homePageLoad();
    notifyListeners();
  }

  Future<void> selectSubCategory(Subcategorylist? value) async {
    selectedSubcategoryList = value;
    id = value!.id!;
    page = 1;
    if (scrollController.hasClients &&
        scrollController.position.maxScrollExtent > 0) {
      scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the curve as needed
      );
    }
    filterApplied = false;
    await homePageLoad();
    notifyListeners();
  }

  Future<void> subcategoryList() async {
    try {
      dataLoading = true;
      subCategoryLoading = true;
      notifyListeners();
      SubCategoryListData? response =
          await homePageService.subcategoryList(selectedCategoryList!.id!);
      if (response != null) {
        if (response.error != true) {
          subCategoryListData = response;
        } else {
          showBotToast(response.message);
        }
      }
      dataLoading = false;
      subCategoryLoading = false;
      notifyListeners();
    } catch (e, s) {
      subCategoryLoading = false;
      dataLoading = false;
      notifyListeners();
      if (e is SocketException) {
        noInternet = true;
      } else if (e is TimeoutException) {
        timeout = true;
      } else {
        print(e);
        print(s);
      }
    }
    notifyListeners();
  }

  Future<void> categoryListLoad() async {
    try {
      CategoryListData? response = await homePageService.categoryList();
      if (response != null) {
        if (response.error != true) {
          categoryListData = response;
          if (categoryListData?.categorylist != null &&
              categoryListData!.categorylist!.isNotEmpty) {
            categoryList.addAll(categoryListData!.categorylist!);
          }
        } else {
          showBotToast(response.message);
        }
      }
      notifyListeners();
    } catch (e, s) {
      if (e is SocketException) {
        noInternet = true;
      } else if (e is TimeoutException) {
        timeout = true;
      } else {
        print(e);
        print(s);
      }
    }
    notifyListeners();
  }

  Future<void> brandListLoad(BuildContext context) async {
    try {
      BrandListData? response = await homePageService.brandList(id);
      if (response != null) {
        if (response.error != true) {
          onFilterClick(context);
          brandListData = response;
        } else {
          showBotToast(response.message);
        }
      }
    } catch (e, s) {
      if (e is SocketException) {
        noInternet = true;
      } else if (e is TimeoutException) {
        timeout = true;
      } else {
        print(e);
        print(s);
      }
    }
    notifyListeners();
  }

  Future<void> brandFilterApply(
    int selectedBrandId,
    BuildContext context,
  ) async {
    Navigator.pop(context);
    page = 1;
    if (scrollController.hasClients &&
        scrollController.position.maxScrollExtent > 0) {
      scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the curve as needed
      );
    }
    brandFilterLoad();
  }

  Future<void> brandFilterLoad() async {
    try {
      isPaging = true;
      HomeListModel? response = await homePageService.brandFilter(id, page);
      if (response != null) {
        if (response.error != true) {
          if (page == 1) {
            homeListModel = response;
          } else {
            homeListModel?.productlist?.addAll(response.productlist ?? []);
          }
        } else {
          showBotToast(response.message);
        }
      }
      isPaging = false;
    } catch (e, s) {
      isPaging = false;
      if (e is SocketException) {
        noInternet = true;
      } else if (e is TimeoutException) {
        timeout = true;
      } else {
        print(e);
        print(s);
      }
    }
    notifyListeners();
  }

  void onFilterClick(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) =>
          FilterModalContent(brandListData, brandFilterApply),
    );
  }
}
