class RecipeImage {
  final String url;

  RecipeImage({this.url});

  factory RecipeImage.fromJson(Map<String, dynamic> json) {
    return RecipeImage(
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
    'imageURL': url,
  };
}