import '../recipe_post.dart';

abstract class RecipePostRepo {
  Future<RecipePost> getRecipePostStatusById(String recipeId);

  Future<List<RecipePost>> getAllRecipePostOfUser(String userId);

  Future<void> removeRecipePost(RecipePost recipePost);
}