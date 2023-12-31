class SubCategoryModel {
  String? categoryId;
  String? categoryName;
  String? lastEdited;
  String? iconLink;

  SubCategoryModel(
      {this.categoryId, this.categoryName, this.lastEdited, this.iconLink});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    lastEdited = json['lastEdited'];
    iconLink = json['iconLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['lastEdited'] = lastEdited;
    data['iconLink'] = iconLink;
    return data;
  }
}
