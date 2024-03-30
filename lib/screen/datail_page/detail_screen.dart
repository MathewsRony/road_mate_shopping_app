
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:road_mate_shopping_app/screen/datail_page/detail_screen_model.dart';
import 'package:road_mate_shopping_app/screen/image_view.dart';
import 'package:stacked/stacked.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(this.id, {super.key});

  final int? id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailScreenViewModel>.reactive(
        onViewModelReady: (model) async {
          model.init(widget.id);
        },
        viewModelBuilder: () => DetailScreenViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Color(0xFFF5F5F5),
            appBar: PreferredSize(
              preferredSize: Size(0, 0),
              child: Container(
                color:  Color(0xFFF5F5F5),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: model.isBusy
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : model.productDetailstData?.productdetails != null &&
                          model.productDetailstData!.productdetails!.isNotEmpty
                      ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Deliver to:"),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.black,
                                        size: 16,
                                      ),
                                      Text("My Shop"),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
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
                            ),
                          ],),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView(
                                children: [
                                  if (model.productDetailstData?.productdetails?.first
                                              .images !=
                                          null &&
                                      model.productDetailstData!.productdetails!.first
                                          .images!.isNotEmpty)
                                    ImageSlider(
                                      model: model,
                                    ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${model.productDetailstData?.productdetails?.first.productName}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      for (int i = 0; i < 5; i++) ...[
                                        const Icon(
                                          Icons.star,
                                          color: Colors.lightGreen,
                                          size: 18,
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "${model.productDetailstData?.productdetails?.first.description}",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Exclusive Launch Offer",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "₹ ${model.productDetailstData?.productdetails?.first.offerPrice}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${model.productDetailstData?.productdetails?.first.price}",
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.lineThrough,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${((((model.productDetailstData?.productdetails?.first.price ?? 0) - (model.productDetailstData?.productdetails?.first.offerPrice ?? 0)) / (model.productDetailstData?.productdetails?.first.price ?? 0)) * 100).toInt()}% off",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.bookmark,
                                                size: 12,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                "Get assured ${((((model.productDetailstData?.productdetails?.first.price ?? 0) - (model.productDetailstData?.productdetails?.first.offerPrice ?? 0)) / (model.productDetailstData?.productdetails?.first.price ?? 0)) * 100).toInt()}% cashback for every order",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                            size: 16,
                                          ),
                                          Text(
                                            "Test Shop, 34/2246 kalamassery",
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Change",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Available coupons for you"),
                                        Icon(Icons.chevron_right),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        ],
                      )
                      : const Center(child: Text("No Data Found")),
            ),
            bottomNavigationBar: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.green,
                        border: Border.all(color: Colors.green),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Text(
                        "Buy now",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
