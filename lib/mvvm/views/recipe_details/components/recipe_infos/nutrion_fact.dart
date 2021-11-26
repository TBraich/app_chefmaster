import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/nutrion_build.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class NutritionFacts extends StatelessWidget {
  const NutritionFacts({
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
            "Nutrition Facts",
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
            children: [
              Row(children: [
                Flexible(
                    flex: 1,
                    child: NutritionBuild(recipe.calories, "Calories", "KCal", 0xFF5a9c6c)),
                SizedBox(width: 10),
                Flexible(
                    flex: 1,
                    child: NutritionBuild(recipe.protein, "Proteins", "Gram", 0xFF82b2f5))
              ]),
              SizedBox(height: 10),
              Row(children: [
                Flexible(
                    flex: 1,
                    child: NutritionBuild(recipe.carb, "Carbs", "Gram", 0xFFf58d71)),
                SizedBox(width: 10),
                Flexible(
                    flex: 1,
                    child: NutritionBuild(recipe.fat, "Fats", "Gram", 0xFFf593eb))
              ])
            ],
          ),
        ),
      ],
    );
  }
}
