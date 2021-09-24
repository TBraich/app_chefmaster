import 'package:chefmaster_app/models/RecipeDetail.dart';
import 'package:chefmaster_app/screens/recipe_details/components/recipe_infos/category_tag.dart';
import 'package:chefmaster_app/screens/recipe_details/components/recipe_infos/nutrion_fact.dart';
import 'package:chefmaster_app/screens/recipe_details/components/recipe_infos/recipe_demo_video.dart';
import 'package:chefmaster_app/screens/recipe_details/components/recipe_infos/recipe_description.dart';
import 'package:chefmaster_app/screens/recipe_details/components/recipe_infos/recipe_ingredients.dart';
import 'package:chefmaster_app/screens/recipe_details/components/recipe_infos/recipe_steps.dart';
import 'package:chefmaster_app/screens/recipe_details/components/recipe_infos/top_rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeInfo extends StatefulWidget {
  final RecipeDetail recipe;

  const RecipeInfo({Key key, this.recipe}) : super(key: key);

  @override
  _RecipeInfoState createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedContainer(
            color: Colors.white,
            child: RecipeDescription(
              recipe: widget.recipe,
              pressOnSeeMore: () {},
            ),
          ),
          RoundedContainer(
            color: Colors.white,
            child: NutritionFacts(
              recipe: widget.recipe,
            ),
          ),
          CategoryTags(data: widget.recipe.categories),
          RoundedContainer(
            color: Colors.white,
            child: Preparations(
              recipe: widget.recipe,
            ),
          ),
          RoundedContainer(
            color: Colors.white,
            child: RecipeStepDetail(
              recipe: widget.recipe,
            ),
          ),
          RoundedContainer(
            color: Colors.white,
            child: RecipeVideoInstruction(
              url: "https://www.youtube.com/watch?v=n01ibksiNmU",
              recipe: widget.recipe,
            ),
          ),
        ],
      ),
    );
  }
}
