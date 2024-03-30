import 'dart:async';
import 'dart:io';

import 'package:road_mate_shopping_app/model/home_list_model.dart';
import 'package:road_mate_shopping_app/model/product_detailst_data.dart';
import 'package:road_mate_shopping_app/rest_api/home_page/home_page_service.dart';
import 'package:road_mate_shopping_app/utils/res/common_widget.dart';
import 'package:road_mate_shopping_app/utils/res/service_locator_setup.dart';
import 'package:stacked/stacked.dart';

class DetailScreenViewModel extends BaseViewModel {
  HomePageService homePageService = locator<HomePageService>();
  ProductDetailstData? productDetailstData;
  int? productId;
  bool noInternet = false;
  bool timeout = false;

  int sliderIndex = 0;

  void init(int? id) async {
    productId = id;
    setBusy(true);
    await detailPageLoad();
    setBusy(false);
  }

  Future<void> detailPageLoad() async {
    try {
      notifyListeners();
      ProductDetailstData? response =
          await homePageService.productdetails(productId);
      if (response != null) {
        if (response.error != true) {
          productDetailstData = response;
        } else {
          showBotToast(response.message);
        }
      }
      notifyListeners();
    } catch (e, s) {
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


  simpleRefresh() {
    notifyListeners();
  }

}
