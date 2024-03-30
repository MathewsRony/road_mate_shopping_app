// To parse this JSON data, do
//
//     final categoryListData = categoryListDataFromJson(jsonString);

import 'dart:convert';

CategoryListData categoryListDataFromJson(String str) => CategoryListData.fromJson(json.decode(str));

String categoryListDataToJson(CategoryListData data) => json.encode(data.toJson());

class CategoryListData {
  bool? error;
  List<Categorylist>? categorylist;
  String? message;

  CategoryListData({
     this.error,
     this.categorylist,
     this.message,
  });

  factory CategoryListData.fromJson(Map<String, dynamic> json) => CategoryListData(
    error: json["error"],
    categorylist: List<Categorylist>.from(json["categorylist"].map((x) => Categorylist.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}

class Categorylist {
  int? id;
  String? categoryName;
  int? catId;
  String? image;
  int? status;

  Categorylist({
     this.id,
     this.categoryName,
     this.catId,
     this.image,
     this.status,
  });

  factory Categorylist.fromJson(Map<String, dynamic> json) => Categorylist(
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
