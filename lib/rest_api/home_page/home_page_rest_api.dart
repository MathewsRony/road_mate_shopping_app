import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:road_mate_shopping_app/model/brand_list_model.dart';
import 'package:road_mate_shopping_app/model/category_list_model.dart';
import 'package:road_mate_shopping_app/model/home_list_model.dart';
import 'package:road_mate_shopping_app/model/product_detailst_data.dart';
import 'package:road_mate_shopping_app/model/subcategory_list_model.dart';
import 'package:road_mate_shopping_app/rest_api/home_page/home_page_service.dart';
import 'package:road_mate_shopping_app/utils/res/rest_res.dart';
import 'package:dio/dio.dart';

@LazySingleton(as: HomePageService)
class HomePageRestApi implements HomePageService {
  Dio dio = Dio(BaseOptions(contentType: 'application/json'));

  @override
  Future<CategoryListData?> categoryList() async {
    try {
      String url = RestRes.baseUrl + RestRes.category_list;
      debugPrint(url);
      Response response = await dio
          .get(
            url,
          )
          .timeout(const Duration(seconds: 30));
      print(response.statusCode);
      debugPrint(response.data);
      if (response.statusCode == 200) {
        return categoryListDataFromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HomeListModel?> searchProduct(
      String searchkey, int searchpaginationindex) async {
    try {
      String url = RestRes.baseUrl + RestRes.search_product;
      debugPrint(url);
      Response response = await dio.post(url, data: {
        "productname": searchkey,
        "index": searchpaginationindex,
      }).timeout(const Duration(seconds: 30));
      print(response.statusCode);
      debugPrint(response.data);
      if (response.statusCode == 200) {
        return homeListModelFromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubCategoryListData?> subcategoryList(int catId) async {
    try {
      String url = RestRes.baseUrl + RestRes.subcategory_list;
      debugPrint(url);
      Response response = await dio.post(url,
          data: {"cat_id": catId}).timeout(const Duration(seconds: 30));
      print(response.statusCode);
      debugPrint(response.data);
      if (response.statusCode == 200) {
        return subCategoryListDataFromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BrandListData?> brandList(int selectedSubcategoryId) async {
    try {
      String url = RestRes.baseUrl + RestRes.brand_list;
      debugPrint(url);

      Map<String, int> bodyData = {
        'subcat_id': selectedSubcategoryId,
      };
      debugPrint(bodyData.toString());
      dio.options.headers = {
        'Accept': "application/json",
      };
      final Response response = await dio.post(
        url,
        data: bodyData,
      );
      print(response.statusCode);
      debugPrint(response.data);
      if (response.statusCode == 200) {
        return brandListDataFromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<HomeListModel?> brandFilter(int brand_id,int page) async {
    try {
      String url = RestRes.baseUrl + RestRes.brandfilter;
      debugPrint(url);

      Map<String, int> bodyData = {
        'brand_id': brand_id,
        'index': page,
      };
      debugPrint(bodyData.toString());
      dio.options.headers = {
        'Accept': "application/json",
      };
      final Response response = await dio.post(
        url,
        data: bodyData,
      );
      print(response.statusCode);
      debugPrint(response.data);
      if (response.statusCode == 200) {
        return homeListModelFromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HomeListModel?> categoryProductList(
      int selectedSubCatId, int paginationindex) async {
    try {
      String url = RestRes.baseUrl + RestRes.category_product_list;
      debugPrint(url);

      Map<String, int> bodyData = {
        "categoryid": selectedSubCatId,
        "index": paginationindex
      };
      dio.options.headers = {
        'Accept': "application/json",
      };
      final Response response = await dio.post(
        url,
        data: bodyData,
      );
      print(response.statusCode);
      debugPrint(response.data);
      if (response.statusCode == 200) {
        return homeListModelFromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductDetailstData?> productdetails(int? productId) async {
    try {
      String url = RestRes.baseUrl + RestRes.product_details;
      debugPrint(url);

      Map<String, int> bodyData = {"productid": productId ?? 0};
      debugPrint(bodyData.toString());
      dio.options.headers = {
        'Accept': "application/json",
      };
      final Response response = await dio.post(
        url,
        data: bodyData,
      );
      print(response.statusCode);
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        return productDetailstDataFromJsonForDio(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
