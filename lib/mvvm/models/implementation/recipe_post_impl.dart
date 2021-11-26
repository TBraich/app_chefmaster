import 'dart:convert';

import 'package:chefmaster_app/mvvm/models/recipe_post.dart';
import 'package:chefmaster_app/mvvm/models/repository/recipe_post_repo.dart';
import 'package:chefmaster_app/providers/post.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:http/http.dart';

class RecipePostImpl with RecipePostRepo {
  PostProvider provider = PostProvider();

  @override
  Future<List<RecipePost>> getAllRecipePostOfUser(String userId) {
    // TODO: implement getAllRecipePostOfUser
    throw UnimplementedError();
  }

  @override
  Future<RecipePost> getRecipePostStatusById(String recipeId) async {
    Response response = await provider.postStatus(recipeId);
    Map<String, dynamic> data = jsonDecode(utf8convert(response.body));
    return RecipePost.fromJson(data);

  }

  @override
  Future<void> removeRecipePost(RecipePost recipePost) {
    // TODO: implement removeRecipePost
    throw UnimplementedError();
  }
}
