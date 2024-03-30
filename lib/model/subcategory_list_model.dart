// To parse this JSON data, do
//
//     final subCategoryListData = subCategoryListDataFromJson(jsonString);

import 'dart:convert';

SubCategoryListData subCategoryListDataFromJson(String str) => SubCategoryListData.fromJson(json.decode(str));

String subCategoryListDataToJson(SubCategoryListData data) => json.encode(data.toJson());

class SubCategoryListData {
  bool? error;
  List<Subcategorylist>? subcategorylist;
  String? message;

  SubCategoryListData({
    this.error,
    this.subcategorylist,
    this.message,
  });

  factory SubCategoryListData.fromJson(Map<String, dynamic> json) => SubCategoryListData(
    error: json["error"],
    subcategorylist: json["subcategorylist"] == null ? [] : List<Subcategorylist>.from(json["subcategorylist"]!.map((x) => Subcategorylist.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "subcategorylist": subcategorylist == null ? [] : List<dynamic>.from(subcategorylist!.map((x) => x.toJson())),
    "message": message,
  };
}

class Subcategorylist {
  int? id;
  String? categoryName;
  int? catId;
  String? image;
  int? status;

  Subcategorylist({
    this.id,
    this.categoryName,
    this.catId,
    this.image,
    this.status,
  });

  factory Subcategorylist.fromJson(Map<String, dynamic> json) => Subcategorylist(
    id: json["id"],
    categoryName: json["category_name"],
    catId: json["cat_id"],
    image: json["image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "cat_id": catId,
    "image": image,
    "status": status,
  };
}
