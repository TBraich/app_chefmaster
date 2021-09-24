import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/nutrion_build.dart';
import 'package:chefmaster_app/models/RecipeDetail.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class Preparations extends StatelessWidget {
  const Preparations({
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
            "Preparations",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (RecipeIngredient ingredient in recipe.ingredients)
                Column(
                    children: [
                      Text(
                          "- ${ingredient.gram} grams of ${ingredient.ingredientName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))
                    ])
            ],
          ),
        ),
      ],
    );
  }
}
