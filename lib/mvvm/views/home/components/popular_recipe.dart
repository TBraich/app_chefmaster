import 'package:chefmaster_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/item_recipe.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';

import 'section_title.dart';

class PopularRecipe extends StatefulWidget {
  final List<RecipeDetail> favRecipes;

  const PopularRecipe({Key key,@required this.favRecipes}) : super(key: key);

  @override
  _PopularRecipeState createState() => _PopularRecipeState();
}

class _PopularRecipeState extends State<PopularRecipe> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Recipes", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (RecipeDetail recipe in widget.favRecipes)
                ItemPopularRecipe(recipe: recipe),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
