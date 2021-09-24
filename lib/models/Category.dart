class Category {
  final int code;
  final String name;
  final String imageUrl;
  final String description;

  Category({this.code, this.imageUrl, this.description, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        code: json["categoryCode"],
        name: json["categoryName"],
        imageUrl: json["imageURL"],
        description: json["description"]);
  }
}

class Categories {
  List<Category> categories;

  Categories({this.categories});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      categories: json['categories'] != null
          ? json['categories']
              .map<Category>((json) => Category.fromJson(json))
              .toList()
          : [
              Category(
                  name: "null",
                  imageUrl: "null",
                  description: "null")
            ],
    );
  }
}
