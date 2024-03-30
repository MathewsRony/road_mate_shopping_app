import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:road_mate_shopping_app/model/subcategory_list_model.dart';
import 'package:road_mate_shopping_app/screen/datail_page/detail_screen.dart';
import 'package:road_mate_shopping_app/screen/home_screen/home_screen_model.dart';
import 'package:road_mate_shopping_app/screen/home_screen_categories.dart';
import 'package:road_mate_shopping_app/screen/nav_bar.dart';
import 'package:road_mate_shopping_app/screen/nav_model.dart';
import 'package:road_mate_shopping_app/screen/search_bar.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;

  List<NavModel> items = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
        onViewModelReady: (model) async {
          model.init();
        },
        viewModelBuilder: () => HomeScreenViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Container(
              color: Colors.white,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: model.isBusy
                  ? SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: double.infinity,
                child: const Center(child: CircularProgressIndicator()),
              )
                  : Column(
                children: [
                  Container(
                    height: 50,
                    child: SearchBarWidget(
                      showCancel:model.showCancel,
                      onClearTap:model.onClearTap,
                      controller: model.textEditingController,
                      onSubmitted: model.searchOnChange,
                      readOnly: true,
                      hasBorder: true,
                    ),
                  ),
                  _buildCategoryList(context, model),
                  if (model.selectedCategoryList!.id != 22 &&
                      !model.subCategoryLoading)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Shop by subcategory",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              if (model.subCategoryListData
                                  ?.subcategorylist !=
                                  null &&
                                  model.subCategoryListData!
                                      .subcategorylist!.isNotEmpty)
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButtonHideUnderline(
                                      child:
                                      DropdownButton<Subcategorylist>(
                                        borderRadius:
                                        const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        hint: const Text(
                                            "Sub Category List"),
                                        value:
                                        model.selectedSubcategoryList,
                                        items: model.subCategoryListData
                                            ?.subcategorylist
                                            ?.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Row(children: <Widget>[
                                              Text(item.categoryName!),
                                            ]),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          model.selectSubCategory(value);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                model.brandListLoad(context);
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(50)),
                                    color: Colors.red,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.commit,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Filter",
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  if (model.dataLoading)
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 2,
                      child: const LinearProgressIndicator(),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${model.selectedCategoryList?.categoryName}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Showing ${model.homeListModel?.productlist
                              ?.length} results",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: model.homeListModel?.productlist != null &&
                        model.homeListModel!.productlist!.isNotEmpty
                        ? GridView.builder(
                      controller: model.scrollController,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemCount:
                      model.homeListModel?.productlist?.length,
                      // Number of items in your list
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(
                                        model.homeListModel
                                            ?.productlist?[index].id),
                              ),
                            );
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "https://roadmate.in/admin/public/market/${model
                                        .homeListModel?.productlist?[index]
                                        .images}",
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder: (_,
                                        __, ___) =>
                                        CupertinoActivityIndicator(),
                                    errorWidget: (context, url,
                                        error) =>
                                        Icon(Icons
                                            .warning_amber_outlined),
                                  ),
                                ),
                                // Replace with your image URL
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 2),
                                  child: Text(
                                    model
                                        .homeListModel
                                        ?.productlist?[index]
                                        .productName ??
                                        "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                          '${model.homeListModel
                                              ?.productlist?[index].price}',
                                          style: const TextStyle(
                                              decoration:
                                              TextDecoration
                                                  .lineThrough)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '₹ ${model.homeListModel
                                            ?.productlist?[index].offerPrice}',
                                      ),
                                      Expanded(
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                    "${model.homeListModel
                                                        ?.productlist?[index]
                                                        .prate ?? 0}"),
                                                const Icon(
                                                  Icons.star,
                                                  color:
                                                  Colors.lightGreen,
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : const Center(
                      child: Text("No Data Found"),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: NavBar(
              pageIndex: selectedTab,
              onTap: (index) {},
            ),
          );
        });
  }

  _buildCategoryList(BuildContext context, HomeScreenViewModel model) {
    return Container(
      height: 90,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: Colors.white,
      child: HomeScreenCategories(model),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: const Text(
        "Featured Products",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 33,
            width: 33,
            child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: Icon(
                  Icons.favorite_outline,
                  color: Colors.black,
                )),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 33,
            width: 33,
            child: const Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                )),
          ),
        ),
      ],
    );
  }
}
