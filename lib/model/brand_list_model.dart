// To parse this JSON data, do
//
//     final brandListData = brandListDataFromJson(jsonString);

import 'dart:convert';

BrandListData brandListDataFromJson(String str) =>
    BrandListData.fromJson(json.decode(str));

String brandListDataToJson(BrandListData data) => json.encode(data.toJson());

class BrandListData {
  bool? error;
  List<BrandList>? brandlist;
  String? message;

  BrandListData({
    this.error,
    this.brandlist,
    this.message,
  });

  factory BrandListData.fromJson(Map<String, dynamic> json) => BrandListData(
        error: json["error"],
        brandlist: json["brandlist"] == null
            ? []
            : List<BrandList>.from(
                json["brandlist"]!.map((x) => BrandList.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "brandlist": brandlist == null
            ? []
            : List<dynamic>.from(brandlist!.map((x) => x.toJson())),
        "message": message,
      };
}

class BrandList {
  int? id;
  int? catId;
  String? brandName;
  int? status;
  int? vendorId;
  bool selected;

  BrandList({
    this.id,
    this.catId,
    this.brandName,
    this.status,
    this.vendorId,
    this.selected = false,
  });

  factory BrandList.fromJson(Map<String, dynamic> json) => BrandList(
        id: json["id"],
        catId: json["cat_id"],
        brandName: json["brand_name"],
        status: json["status"],
        vendorId: json["vendor_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "brand_name": brandName,
        "status": status,
        "vendor_id": vendorId,
      };
}
