import 'dart:async';

import 'package:chefmaster_app/mvvm/models/recipe_comments.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/mvvm/models/recipe_post.dart';
import 'package:chefmaster_app/mvvm/models/recipe_upvote.dart';
import 'package:chefmaster_app/mvvm/view_models/recipe_post_view_model.dart';
import 'package:chefmaster_app/providers/post.dart';
import 'package:chefmaster_app/mvvm/views/recipe_details/components/socializes/comment_item.dart';
import 'package:chefmaster_app/utils/common_functions.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RecipeSocializes extends StatefulWidget {
  final RecipeDetail recipe;

  const RecipeSocializes({Key key, this.recipe}) : super(key: key);

  @override
  _RecipeSocializesState createState() => _RecipeSocializesState();
}

class _RecipeSocializesState extends State<RecipeSocializes> {
  RecipePostViewModel viewModel;
  RecipePost post;
  static final String UPVOTED = "upvoted";
  static final String COMMENTS = "comments";
  static final String UPVOTES = "upvotes";
  static final String hasUpvoted = "hasUpvoted";
  static final String hasDownvoted = "hasDownvoted";
  static final String NUMBER_OF_VOTES = "numberOfVotes";

  StreamController streamController = StreamController();
  TextEditingController commentController = TextEditingController();
  PostProvider provider = PostProvider();
  Timer timer;
  int upvoteNumber = 0;
  Map data = {hasUpvoted: false, hasDownvoted: false};

  Future normalGetData() async {
    // Response response = await provider.postStatus(widget.recipe.recipeId);
    // data = jsonDecode(utf8convert(response.body));
    // print('normally get data');
    //
    // if (data[UPVOTED] == "UPVOTE") {
    //   data[hasUpvoted] = true;
    //   data[hasDownvoted] = false;
    // } else if (data[UPVOTED] == "DOWNVOTE") {
    //   data[hasUpvoted] = false;
    //   data[hasDownvoted] = true;
    // } else if (data[UPVOTED] == "NOT") {
    //   data[hasUpvoted] = false;
    //   data[hasDownvoted] = false;
    // }
    //
    // data[NUMBER_OF_VOTES] = countUpvoteNumber(data[UPVOTES]);
    //
    // //Add your data to stream
    // streamController.add(data);
    viewModel = RecipePostViewModel(widget.recipe.recipeId);
    await viewModel.updateRecipePost();

    post = viewModel.post;
    post.numberOfVotes = countUpvoteNumber(post.upvotes);

    //Add your data to stream
    streamController.add(post);
  }

  Future autoGetData() async {
    // Response response = await provider.postStatus(widget.recipe.recipeId);
    // data = jsonDecode(utf8convert(response.body));
    // print('automatic get data');
    //
    //
    //
    // if (data[UPVOTED] == "UPVOTE") {
    //   data[hasUpvoted] = true;
    //   data[hasDownvoted] = false;
    // } else if (data[UPVOTED] == "DOWNVOTE") {
    //   data[hasUpvoted] = false;
    //   data[hasDownvoted] = true;
    // } else if (data[UPVOTED] == "NOT") {
    //   data[hasUpvoted] = false;
    //   data[hasDownvoted] = false;
    // }
    //
    // data[NUMBER_OF_VOTES] = countUpvoteNumber(data[UPVOTES]);

    viewModel = RecipePostViewModel(widget.recipe.recipeId);
    await viewModel.updateRecipePost();

    post = viewModel.post;
    post.numberOfVotes = countUpvoteNumber(post.upvotes);


    //Add your data to stream
    streamController.add(post);
  }

  @override
  void initState() {
    autoGetData();
    //Check the server every 5 minutes
    timer = Timer.periodic(Duration(seconds: 30), (timer) => autoGetData());

    super.initState();
  }

  @override
  void dispose() {
    //cancel the timer
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  int countUpvoteNumber(List<RecipeUpvotes> upvotes) {
    if (upvotes == null) {
      return 0;
    }
    int count = 0;
    for (var item in upvotes) {
      if (item.isUpvote) {
        count++;
      } else {
        count--;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: viewModel,
        child: StreamBuilder(
            stream: streamController.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                RecipePost post = snapshot.data;
                return Container(
                  margin: EdgeInsets.only(left: 6, right: 6, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildUpvote(post),
                      Expanded(child: buildComments(post.comments)),
                      Divider(),
                      ListTile(
                        title: TextFormField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Write your comment...',
                            contentPadding:
                                new EdgeInsets.only(left: 20.0, right: 20.0),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            sendAComment(widget.recipe.recipeId,
                                commentController.value.text);
                            commentController.clear();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }));
  }

  buildComments(List<RecipeComments> comments) {
    // print('${comments[1]}');
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 6),
            child: comments != null
                ? ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: comments.map((document) {
                      var timeNow = DateTime.now().toUtc();
                      var diff = timeBetween(document.createAt, timeNow);
                      // print('--> diff: ${diff.values.single} - ${diff.keys.single}');
                      return CommentItem(
                        imageUrl: document.userImage,
                        userName: document.userName,
                        content: document.content,
                        timeComment:
                            '${diff.values.single} ${diff.keys.single} ago',
                      );
                    }).toList(),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  buildUpvote(RecipePost post) {
    return (post.votedState == null)
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: (post.votedState == VotedState.UPVOTED)
                      ? kPrimaryLightColor
                      : Colors.white,
                  shape: CircleBorder(),
                ),
                child: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: (post.votedState == VotedState.UPVOTED)
                      ? Colors.white
                      : Colors.grey,
                ),
                onPressed: () {
                  doSubmiteUpvote(widget.recipe.recipeId, post, true);
                },
              ),
              SizedBox(width: 10),
              Text("${post.numberOfVotes}"),
              SizedBox(width: 10),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: (post.votedState == VotedState.DOWNVOTED)
                      ? kPrimaryLightColor
                      : Colors.white,
                  shape: CircleBorder(),
                ),
                child: Icon(
                  Icons.thumb_down_alt_outlined,
                  color: (post.votedState == VotedState.DOWNVOTED)
                      ? Colors.white
                      : Colors.grey,
                ),
                onPressed: () {
                  doSubmiteUpvote(widget.recipe.recipeId, post, false);
                },
              ),
            ],
          );
  }

  void sendAComment(String recipeId, String comment) {
    provider.comment(recipeId, comment);
    normalGetData();
  }

  void doSubmiteUpvote(String recipeId, RecipePost post, bool isUpvote) {
    bool currentUpvote = (post.votedState == VotedState.UPVOTED);
    bool currentDownvote = (post.votedState == VotedState.DOWNVOTED);
    provider.upvote(recipeId, isUpvote);

    // if upvote +1 / else -1
    if (isUpvote && currentUpvote) {
      // Unupvote
      // minus voteNumber for upvote + upvoted
      post.numberOfVotes--;
      post.votedState = VotedState.UNVOTED;
    } else if (isUpvote && !currentUpvote) {
      // Upvote
      // plus voteNumber for upvote + not upvoted
      post.numberOfVotes++;
      post.votedState = VotedState.UPVOTED;
      if (currentDownvote) {
        post.numberOfVotes++;
      }
    } else if (!isUpvote && currentDownvote) {
      print('3');
      // Undownvote
      // plus voteNumber for downvote + downvoted
      post.numberOfVotes++;
      post.votedState = VotedState.UNVOTED;
    } else if (!isUpvote && !currentDownvote) {
      // Downvote
      // minus voteNumber for downvote + not downvoted
      post.numberOfVotes--;
      post.votedState = VotedState.DOWNVOTED;
      if (currentUpvote) {
        post.numberOfVotes--;
      }
    }

    streamController.add(post);
  }
}
