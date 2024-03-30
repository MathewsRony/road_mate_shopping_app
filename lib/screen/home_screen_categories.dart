import 'package:flutter/material.dart';
import 'package:road_mate_shopping_app/screen/category_list.dart';
import 'package:road_mate_shopping_app/screen/home_screen/home_screen_model.dart';

class HomeScreenCategories extends StatelessWidget {
  const HomeScreenCategories(this.model, {Key? key}) : super(key: key);
  final HomeScreenViewModel? model;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model?.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          if (model?.categoryList[index].image == null) {
            return CategoryListItem(
                ontap: () async {
                  model?.selectCategory(index);
                },
                title: model?.categoryList[index].categoryName,
                selected: model?.selectedCategoryList?.id ==
                    model?.categoryList[index].id);
          } else {
            return CategoryIconListItem(
                ontap: () async {
                  model?.selectCategory(index);
                },
                image: model?.categoryList[index].image,
                selected: model?.selectedCategoryList?.id ==
                    model?.categoryList[index].id);
          }
        });
  }
}
