class RecipeComments {
  String userId;
  String userName;
  String userImage;
  String content;
  DateTime createAt;

  RecipeComments(
      {this.userId,
      this.userName,
      this.userImage,
      this.content,
      this.createAt});

  factory RecipeComments.fromJson(Map<String, dynamic> json) {
    return RecipeComments(
        userId: json["userID"],
        userName: json["userName"],
        userImage: json["userImage"],
        content: json["content"],
        createAt: DateTime.parse(json["created_at"]));
  }
}
