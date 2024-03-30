// To parse this JSON data, do
//
//     final homeListModel = homeListModelFromJson(jsonString);

import 'dart:convert';

HomeListModel homeListModelFromJson(String str) =>
    HomeListModel.fromJson(json.decode(str));

String homeListModelToJson(HomeListModel data) => json.encode(data.toJson());

class HomeListModel {
  bool? error;
  List<Productlist>? productlist;
  String? message;

  HomeListModel({
    this.error,
    this.productlist,
    this.message,
  });

  factory HomeListModel.fromJson(Map<String, dynamic> json) => HomeListModel(
        error: json["error"],
        productlist: json["productlist"] == null
            ? json["product"] == null
                ? []
                : List<Productlist>.from(
                    json["product"]!.map((x) => Productlist.fromJson(x)))
            : List<Productlist>.from(
                json["productlist"]!.map((x) => Productlist.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "productlist": productlist == null
            ? []
            : List<dynamic>.from(productlist!.map((x) => x.toJson())),
        "message": message,
      };
}

class Productlist {
  int? id;
  int? brandId;
  String? productName;
  int? offerPrice;
  int? price;
  int? sellingRate;
  int? sellingMrp;
  String? description;
  int? status;
  int? hsncode;
  int? priority;
  int? prate;
  int? noReturnDays;
  int? b2CStatus;
  String? images;

  Productlist({
    this.id,
    this.brandId,
    this.productName,
    this.offerPrice,
    this.price,
    this.sellingRate,
    this.sellingMrp,
    this.description,
    this.status,
    this.hsncode,
    this.priority,
    this.prate,
    this.noReturnDays,
    this.b2CStatus,
    this.images,
  });

  factory Productlist.fromJson(Map<String, dynamic> json) => Productlist(
        id: json["id"],
        brandId: json["brand_id"],
        productName: json["product_name"],
        offerPrice: json["offer_price"],
        price: json["price"],
        sellingRate: json["selling_rate"],
        sellingMrp: json["selling_mrp"],
        description: json["description"],
        status: json["status"],
        hsncode: json["hsncode"],
        priority: json["priority"],
        prate: json["prate"],
        noReturnDays: json["no_return_days"],
        b2CStatus: json["b2c_status"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_id": brandId,
        "product_name": productName,
        "offer_price": offerPrice,
        "price": price,
        "selling_rate": sellingRate,
        "selling_mrp": sellingMrp,
        "description": description,
        "status": status,
        "hsncode": hsncode,
        "priority": priority,
        "prate": prate,
        "no_return_days": noReturnDays,
        "b2c_status": b2CStatus,
        "images": images,
      };
}
