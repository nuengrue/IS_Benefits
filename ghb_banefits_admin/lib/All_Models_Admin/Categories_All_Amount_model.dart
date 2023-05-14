import 'dart:convert';

class CategoriesAllamount {
  final String name;
  late int amountApprove;
  late int amountRequest;
  late int amountReject;
  CategoriesAllamount(
      this.name, this.amountApprove, this.amountRequest, this.amountReject);

  factory CategoriesAllamount.fromJson(Map<String, dynamic> json) {
    return CategoriesAllamount(
      json['name'],
      json['amountApprove'],
      json['amountRequest'],
      json['amountReject'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['amountApprove'] = amountApprove;
    data['amountRequest'] = amountRequest;
    data['amountReject'] = amountReject;
    return data;
  }

  static List<CategoriesAllamount> parseApplList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<CategoriesAllamount> listData = parsed
        .map<CategoriesAllamount>((json) => CategoriesAllamount.fromJson(json))
        .toList();
    return listData;
  }
}