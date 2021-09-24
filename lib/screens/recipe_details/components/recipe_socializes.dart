import 'dart:async';
import 'dart:convert';

import 'package:chefmaster_app/models/RecipeDetail.dart';
import 'package:chefmaster_app/providers/post.dart';
import 'package:chefmaster_app/screens/recipe_details/components/socializes/comment_item.dart';
import 'package:chefmaster_app/utils/common_functions.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RecipeSocializes extends StatefulWidget {
  final RecipeDetail recipe;

  const RecipeSocializes({Key key, this.recipe}) : super(key: key);

  @override
  _RecipeSocializesState createState() => _RecipeSocializesState();
}

class _RecipeSocializesState extends State<RecipeSocializes> {
  StreamController streamController = StreamController();
  TextEditingController commentController = TextEditingController();
  PostProvider provider = PostProvider();
  bool hasDownvote;
  bool hasUpvote;
  Timer timer;
  int upvoteNumber = 0;

  Future getData() async {
    Response response = await provider.postStatus(widget.recipe.recipeId);
    var data = jsonDecode(response.body);
    // String status = data['upvoted'];
    // if (status == "UPVOTE") {
    //     hasUpvote = true;
    //     hasDownvote = false;
    // } else if (status == "DOWNVOTE") {
    //     hasUpvote = false;
    //     hasDownvote = true;
    // } else if (status == "NOT"){
    //     hasUpvote = false;
    //     hasDownvote = false;
    // }

    //Add your data to stream
    streamController.add(data);
  }

  @override
  void initState() {
    getData();

    //Check the server every 5 minutes
    timer = Timer.periodic(Duration(seconds: 30), (timer) => getData());

    super.initState();
  }

  @override
  void dispose() {
    //cancel the timer
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            List comments = content['comments'];
            List upvotes = content['upvotes'];
            String status = content['upvoted'];
            upvoteNumber = upvotes==null?0:upvotes.length;
            return Container(
              margin: EdgeInsets.only(left: 6, right: 6, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildUpvote(upvotes, status),
                  Expanded(child: buildComments(comments)),
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
        });
  }

  buildComments(List<dynamic> comments) {
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
                      var parsedDate =
                          DateTime.parse('${document['created_at']}');
                      var timeNow = DateTime.now().toUtc();
                      var diff = timeBetween(parsedDate, timeNow);
                      // print('--> diff: ${diff.values.single} - ${diff.keys.single}');
                      return CommentItem(
                        imageUrl: document['userImage'],
                        userName: document['userName'],
                        content: document['content'],
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

  buildUpvote(List<dynamic> upvotes, String status) {
    bool hasDownvote;
    bool hasUpvote;

    if (status == "UPVOTE") {
      hasUpvote = true;
      hasDownvote = false;
    } else if (status == "DOWNVOTE") {
      hasUpvote = false;
      hasDownvote = true;
    } else if (status == "NOT"){
      hasUpvote = false;
      hasDownvote = false;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: hasUpvote ? kPrimaryLightColor : Colors.white,
            shape: CircleBorder(),
          ),
          child: Icon(
            Icons.thumb_up_alt_outlined,
            color: hasUpvote ? Colors.white : Colors.grey,
          ),
          onPressed: () {
            doSubmiteUpvote(widget.recipe.recipeId, true);
          },
        ),
        SizedBox(width: 10),
        Text("$upvoteNumber"),
        SizedBox(width: 10),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: hasDownvote ? kPrimaryLightColor : Colors.white,
            shape: CircleBorder(),
          ),
          child: Icon(
            Icons.thumb_down_alt_outlined,
            color: hasDownvote ? Colors.white : Colors.grey,
          ),
          onPressed: () {
            doSubmiteUpvote(widget.recipe.recipeId, false);
          },
        ),
      ],
    );
  }

  void sendAComment(String recipeId, String comment) {
    provider.comment(recipeId, comment);
    getData();
  }

  void doSubmiteUpvote(String recipeId, bool isUpvote) {
    provider.upvote(recipeId, isUpvote);
    getData();
  }
}
