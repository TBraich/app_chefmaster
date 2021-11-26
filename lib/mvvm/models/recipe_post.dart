import 'package:chefmaster_app/mvvm/models/recipe_comments.dart';
import 'package:chefmaster_app/mvvm/models/recipe_upvote.dart';

enum VotedState {UPVOTED, DOWNVOTED, UNVOTED}

class RecipePost {
  String upvoted;
  List<RecipeComments> comments;
  List<RecipeUpvotes> upvotes;
  VotedState votedState;
  int numberOfVotes;
  bool currentVoteStatus;

  RecipePost({this.upvoted, this.comments, this.upvotes, this.numberOfVotes});

  factory RecipePost.fromJson(Map<String, dynamic> json) {
    // parse data recipe upvotes
    List<RecipeUpvotes> upvotes = json['upvotes'] != null
        ? json['upvotes']
        .map<RecipeUpvotes>((json) => RecipeUpvotes.fromJson(json))
        .toList()
        : [];

    // parse data recipe comments
    List<RecipeComments> comments = json['comments'] != null
        ? json['comments']
        .map<RecipeComments>((json) => RecipeComments.fromJson(json))
        .toList()
        : [];

    return RecipePost(
      upvoted: json['upvoted'],
      upvotes: upvotes,
      comments: comments,
      numberOfVotes: 0,
    );
  }
}