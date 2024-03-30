import 'package:road_mate_shopping_app/model/brand_list_model.dart';
import 'package:road_mate_shopping_app/model/category_list_model.dart';
import 'package:road_mate_shopping_app/model/home_list_model.dart';
import 'package:road_mate_shopping_app/model/product_detailst_data.dart';
import 'package:road_mate_shopping_app/model/subcategory_list_model.dart';

abstract class HomePageService {
  Future<CategoryListData?> categoryList();

  Future<HomeListModel?> searchProduct(
    String searchKey,
    int searchPaginationIndex,
  );
  Future<SubCategoryListData?> subcategoryList(int catId);
  Future<BrandListData?> brandList(int selectedSubcategoryId);

  Future<HomeListModel?> categoryProductList(int selectedSubCatId,int paginationindex);

  Future<ProductDetailstData?> productdetails(int? productId);

  Future<HomeListModel?> brandFilter(int brand_id, int page);
}
