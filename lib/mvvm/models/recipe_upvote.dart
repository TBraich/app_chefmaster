class RecipeUpvotes {
  String userId;
  String userName;
  bool isUpvote;
  DateTime createAt;

  RecipeUpvotes({this.userId, this.userName, this.isUpvote, this.createAt});

  factory RecipeUpvotes.fromJson(Map<String, dynamic> json) {
    return RecipeUpvotes(
      userId: json["userID"],
      userName: json["userName"],
      isUpvote: json["isUpvote"],
      createAt: DateTime.parse(json["created_at"])
    );
  }
}