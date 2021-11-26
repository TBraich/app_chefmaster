import 'package:chefmaster_app/mvvm/models/category.dart';
import 'package:chefmaster_app/mvvm/models/recipe_image.dart';
import 'package:chefmaster_app/mvvm/models/recipe_step.dart';

import 'ingredient.dart';

class RecipeDetail {
  final String recipeId;
  final String recipeName, coverImageUrl, description;
  final List<RecipeImage> detailImageUrl;
  final List<RecipeStep> recipeSteps;
  final List<Ingredient> ingredients;
  final List<Category> categories;
  final bool isFavorite;
  

  int calories, protein, carb, fat;
  final String creator;
  final int upvote;

  RecipeDetail({
    this.recipeId,
    this.recipeName,
    this.coverImageUrl,
    this.description,
    this.detailImageUrl,
    this.recipeSteps,
    this.ingredients,
    this.categories,
    this.calories,
    this.protein,
    this.carb,
    this.fat,
    this.creator,
    this.upvote,
    this.isFavorite,
  });

  static RecipeDetail getRecipeInstance() {
    return RecipeDetail(
        recipeId: "recipeId",
        recipeName: "default",
        coverImageUrl:
        "https://keyassets-p2.timeincuk.net/wp/prod/wp-content/uploads/sites/63/2008/09/Black-Forest-gateau-cake-scaled.jpg",
        description: "default description",
        detailImageUrl: [],
        recipeSteps: [],
        ingredients: [],
        calories: 0,
        categories: [],
        protein: 0,
        carb: 0,
        fat: 0,
        upvote: 0,
        isFavorite: false,
        creator: "unknown");
  }

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    List<RecipeStep> steps = json['recipeSteps'] != null
        ? json['recipeSteps']
            .map<RecipeStep>((json) => RecipeStep.fromJson(json))
            .toList()
        : [RecipeStep(step: 1, description: "updating")];

    List<RecipeImage> images = json['recipeImages'] != null
        ? json['recipeImages']
            .map<RecipeImage>((json) => RecipeImage.fromJson(json))
            .toList()
        : [];
    images.insert(0, new RecipeImage(url: json["coverImageURL"]));

    List<Ingredient> ingredients = json['ingredients'] != null
        ? json['ingredients']
            .map<Ingredient>((json) => Ingredient.fromJson(json))
            .toList()
        : [
            Ingredient(
              ingredientName: "ingredientName",
              gram: 0,
              calo: 0,
              protein: 0,
              carb: 0,
              fat: 0,
            )
          ];

    List<Category> categories = json['categories'] != null
        ? json['categories']
            .map<Category>((json) => Category.fromJson(json))
            .toList()
        : [
            Category(
              name: "unknown",
            )
          ];

    int calories = 0, protein = 0, carb = 0, fat = 0;

    for (Ingredient ingredient in ingredients) {
      calories += ingredient.calo;
      protein += ingredient.protein;
      carb += ingredient.carb;
      fat += ingredient.fat;
    }

    return RecipeDetail(
        recipeId: json['recipeID'],
        recipeName: json['recipeName'],
        description: json['description'],
        coverImageUrl: json["coverImageURL"],
        recipeSteps: steps,
        detailImageUrl: images,
        ingredients: ingredients,
        calories: calories,
        categories: categories,
        protein: protein,
        carb: carb,
        fat: fat,
        upvote: json["upvote"],
        isFavorite: json["isFavorite"],
        creator: json['createdBy']);
  }

  Map<String, dynamic> toJson() => {
        "recipeID": recipeId,
        "recipeName": recipeName,
        "coverImageURL": coverImageUrl,
        "createdBy": creator,
        "description": description,
        "ingredients": List.generate(
            ingredients.length, (index) => ingredients[index].toJson()),
        "steps": List.generate(
            recipeSteps.length, (index) => recipeSteps[index].toJson()),
        "images": List.generate(
            detailImageUrl.length, (index) => detailImageUrl[index].toJson()),
        "categories": [
          {"categoryCode": 3},
        ],
        "upvote": 0
      };
}

class Recipes {
  List<RecipeDetail> recipes;

  Recipes({this.recipes});

  factory Recipes.fromJson(Map<String, dynamic> json) {
    return Recipes(
      recipes: json['listRecipes'] != null
          ? json['listRecipes']
              .map<RecipeDetail>((json) => RecipeDetail.fromJson(json))
              .toList()
          : [
              RecipeDetail(
                  recipeId: "recipeId",
                  recipeName: "default",
                  coverImageUrl:
                      "https://keyassets-p2.timeincuk.net/wp/prod/wp-content/uploads/sites/63/2008/09/Black-Forest-gateau-cake-scaled.jpg",
                  description: "default description",
                  creator: "default")
            ],
    );
  }

  factory Recipes.fromJsonForFavorite(Map<String, dynamic> json) {
    return Recipes(
      recipes: json['listRecipes'] != null
          ? json['listRecipes']
          .map<RecipeDetail>((json) => RecipeDetail.fromJson(json))
          .toList()
          : [],
    );
  }
}
