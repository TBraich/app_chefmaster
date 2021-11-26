import 'package:chefmaster_app/mvvm/models/recipe_step.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class RecipeStepDetail extends StatelessWidget {
  const RecipeStepDetail({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  final RecipeDetail recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            "Recipe methods",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (RecipeStep step in recipe.recipeSteps)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Step ${step.step}".trim(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: kPrimaryColor),
                    ),
                    SizedBox(height: 2),
                    Text(
                      step.description.trim(),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 3),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
