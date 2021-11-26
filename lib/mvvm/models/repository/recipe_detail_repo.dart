import '../recipe_detail.dart';

abstract class RecipeDetailRepo {
  Future<RecipeDetail> getRecipeDetailById(String recipeId);

  Future<List<RecipeDetail>> getUserFavoriteRecipes(String userId);

  Future<List<RecipeDetail>> getAllRecipeDetail();

}