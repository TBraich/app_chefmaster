import 'package:chefmaster_app/mvvm/models/implementation/recipe_post_impl.dart';
import 'package:chefmaster_app/mvvm/models/recipe_post.dart';
import 'package:chefmaster_app/mvvm/models/repository/recipe_post_repo.dart';
import 'package:scoped_model/scoped_model.dart';



class RecipePostViewModel extends Model {
  RecipePostRepo recipeRepo = RecipePostImpl();
  String recipeId;
  VotedState votedState;
  int numberOfVotes;

  RecipePost post;

  RecipePostViewModel(String recipeId) {
    this.recipeId = recipeId;
    updateRecipePost();
    numberOfVotes = 0;
  }

  Future<void> updateRecipePost() async {
    post = await recipeRepo.getRecipePostStatusById(recipeId);
    if (post.upvoted == "UPVOTE") {
      post.votedState = VotedState.UPVOTED;
    } else if (post.upvoted == "DOWNVOTE") {
      post.votedState = VotedState.DOWNVOTED;
    } else if (post.upvoted == "NOT") {
      post.votedState = VotedState.UNVOTED;
    }

    notifyListeners();
  }
}
