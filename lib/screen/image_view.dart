
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:road_mate_shopping_app/screen/datail_page/detail_screen_model.dart';

class ImageSlider extends StatefulWidget {
  final DetailScreenViewModel model;

  ImageSlider({required this.model});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                height: MediaQuery.of(context).size.width >= 900
                    ? MediaQuery.of(context).size.height * 0.4
                    : MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.height * 0.32
                    : MediaQuery.of(context).size.height * 0.4,
                viewportFraction: MediaQuery.of(context).size.width >= 900
                    ? 0.45
                    : MediaQuery.of(context).size.width >= 600
                    ? 0.55
                    : 1.0,
                aspectRatio: 2.0,
                enlargeFactor: 0.3,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                onPageChanged: (index, reason) {
                  widget.model.sliderIndex = index;
                  widget.model.notifyListeners();
                  if (index <
                      widget.model.productDetailstData!.productdetails!.first
                          .images!.length -
                          1) {
                    precacheImage(
                        NetworkImage(
                            "https://roadmate.in/admin/public/market/${widget.model.productDetailstData!.productdetails!.first.images![index + 1]}"),
                        context);
                  }
                  widget.model.simpleRefresh();
                },
              ),
              items: widget
                  .model.productDetailstData!.productdetails!.first.images!
                  .map(
                    (item) => Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: CachedNetworkImage(
                    imageUrl:
                    "https://roadmate.in/admin/public/market/$item",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width >= 900
                        ? MediaQuery.of(context).size.height * 0.4
                        : MediaQuery.of(context).size.width >= 600
                        ? MediaQuery.of(context).size.height * 0.32
                        : MediaQuery.of(context).size.height * 0.4,
                    progressIndicatorBuilder: (_, __, ___) =>
                        CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.warning_amber_outlined),
                  ),
                ),
              )
                  .toList(),
            ),
            Positioned(
              left: 20,
              child: InkWell(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white10,
                        border: Border.all(color: Colors.grey)),
                    child: Icon(Icons.chevron_left)),
                onTap: () {
                  carouselController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
              ),
            ),
            Positioned(
              right: 20,
              child: InkWell(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: Icon(Icons.chevron_right)),
                onTap: () {
                  carouselController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
              ),
            ),
          ],
        ),
        DotsIndicator(
          dotsCount: widget.model.productDetailstData?.productdetails?.first
              .images?.length ??
              0,
          position: widget.model.sliderIndex,
          decorator: DotsDecorator(
            activeColor: Colors.red,
            color: Colors.grey,
            size: const Size.square(5.0),
            activeSize: const Size.square(5.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
