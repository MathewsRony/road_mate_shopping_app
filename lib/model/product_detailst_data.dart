// To parse this JSON data, do
//
//     final productDetailstData = productDetailstDataFromJson(jsonString);

import 'dart:convert';

ProductDetailstData productDetailstDataFromJson(String str) => ProductDetailstData.fromJson(json.decode(str));
ProductDetailstData productDetailstDataFromJsonForDio(str) =>
    ProductDetailstData.fromJson(str);
String productDetailstDataToJson(ProductDetailstData data) => json.encode(data.toJson());

class ProductDetailstData {
  bool? error;
  List<Productdetail>? productdetails;
  String? message;

  ProductDetailstData({
    this.error,
    this.productdetails,
    this.message,
  });

  factory ProductDetailstData.fromJson(Map<String, dynamic> json) => ProductDetailstData(
    error: json["error"],
    productdetails: json["productdetails"] == null ? [] : List<Productdetail>.from(json["productdetails"]!.map((x) => Productdetail.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "productdetails": productdetails == null ? [] : List<dynamic>.from(productdetails!.map((x) => x.toJson())),
    "message": message,
  };
}

class Productdetail {
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
  int? catId;
  List<String>? images;

  Productdetail({
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
    this.catId,
    this.images,
  });

  factory Productdetail.fromJson(Map<String, dynamic> json) => Productdetail(
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
    catId: json["cat_id"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
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
    "cat_id": catId,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}
