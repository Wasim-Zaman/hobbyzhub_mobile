class CategoryModel {
  String? categoryId;
  String? categoryName;
  String? iconLink;

  CategoryModel({this.categoryId, this.categoryName, this.iconLink});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    iconLink = json['iconLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['iconLink'] = iconLink;
    return data;
  }
}
