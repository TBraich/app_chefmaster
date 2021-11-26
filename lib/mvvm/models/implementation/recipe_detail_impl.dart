import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/mvvm/models/repository/recipe_detail_repo.dart';

class RecipeDetailImpl extends RecipeDetailRepo {
  @override
  Future<List<RecipeDetail>> getAllRecipeDetail() {
    // TODO: implement getAllRecipeDetail
    throw UnimplementedError();
  }

  @override
  Future<RecipeDetail> getRecipeDetailById(String recipeId) {
    // TODO: implement getRecipeDetailById
    throw UnimplementedError();
  }

  @override
  Future<List<RecipeDetail>> getUserFavoriteRecipes(String userId) {
    // TODO: implement getUserFavoriteRecipes
    throw UnimplementedError();
  }

}