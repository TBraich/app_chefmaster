import 'package:flutter/material.dart';
import 'package:chefmaster_app/models/RecipeDetail.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/utils/constants.dart';

import 'components/body.dart';
import '../../components/custom_app_bar.dart';

class RecipeDetailTransfer extends StatefulWidget {
  final String recipeID;

  const RecipeDetailTransfer({Key key, this.recipeID}) : super(key: key);

  @override
  _RecipeDetailTransferState createState() =>
      _RecipeDetailTransferState(this.recipeID);
}

class _RecipeDetailTransferState extends State<RecipeDetailTransfer> {
  AuthProvider auth = new AuthProvider();
  RecipeDetail recipe;

  _RecipeDetailTransferState(String recipeID) {
    doGetRecipeDetail(recipeID);
  }

  @override
  Widget build(BuildContext context) {
    return recipe != null
        ? Scaffold(
            backgroundColor: Color(0xFFF5F6F9),
            appBar: CustomAppBar(
              optsWidget: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      "${recipe != null ? recipe.upvote : 0}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                  ],
                ),
              ), label: '',
            ),
            body: Body(recipe: recipe),
          )
        : Scaffold();
  }

  void doGetRecipeDetail(String id) {
    final Future<Map<String, dynamic>> successfulMessage =
        auth.getRecipeDetail(id);
    successfulMessage.then((response) {
      if (response['status']) {
        setState(() {
          recipe = response['recipe'];
        });
      } else {
        print(response);
      }
    });
  }
}

class RecipeDetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final RecipeDetailsArguments recipeArg =
        ModalRoute.of(context).settings.arguments as RecipeDetailsArguments;
    return RecipeDetailTransfer(recipeID: recipeArg.recipeID);
  }
}

class RecipeDetailsArguments {
  final String recipeID;

  RecipeDetailsArguments({this.recipeID});
}
