class Ingredient {
  String ingredientName;
  int gram;
  int calo;
  int protein;
  int carb;
  int fat;

  Ingredient(
      {this.ingredientName,
        this.gram,
        this.calo,
        this.protein,
        this.carb,
        this.fat});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredientName: json["ingredientName"],
      gram: json["gramNumber"],
      calo: json["caloNumber"],
      protein: json["proteinNumber"],
      carb: json["carbNumber"],
      fat: json["fatNumber"],
    );
  }

  Map<String, dynamic> toJson() => {
    'ingredientName': ingredientName,
    'gramNumber': gram,
  };
}