// To parse this JSON data, do
//
//     final menuDataModel = menuDataModelFromJson(jsonString);

import 'dart:convert';

Map<String, List<MenuDataModel>> menuDataModelFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<MenuDataModel>>(k, List<MenuDataModel>.from(v.map((x) => MenuDataModel.fromJson(x)))));

String menuDataModelToJson(Map<String, List<MenuDataModel>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));

class MenuDataModel {
  MenuDataModel({
    this.name,
    this.price,
    this.inStock,
    this.unit,
    this.bestSeller,
  });

  String? name;
  int? price;
  bool? inStock;
  int? unit;
  bool ? bestSeller;

  factory MenuDataModel.fromJson(Map<String, dynamic> json) => MenuDataModel(
    name: json["name"],
    price: json["price"],
    inStock: json["inStock"],
    unit: 0,
    bestSeller: false
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "inStock": inStock,
    "unit" : unit,
    "bestSeller" : bestSeller
  };
}
