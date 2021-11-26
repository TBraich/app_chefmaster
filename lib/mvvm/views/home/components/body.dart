import 'package:chefmaster_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/mvvm/models/category.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/mvvm/views/home/components/pop_category.dart';

import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_recipe.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AuthProvider auth = new AuthProvider();
  List<RecipeDetail> favRecipes = [];
  List<Category> categories = [];

  _BodyState() {
    doGetPopRecipe();
    doGetCategory();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // refresh data
    Future<void> _pullRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
    }
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              // HomeHeader(),
              // SizedBox(height: getProportionateScreenWidth(10)),
              DiscountBanner(),
              CategoriesButton(),
              SpecialOffers(),
              SizedBox(height: getProportionateScreenWidth(30)),
              PopularRecipe(favRecipes: favRecipes,),
              SizedBox(height: getProportionateScreenWidth(30)),
              CategorySlide(categories: categories,),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
    );
  }

  void doGetPopRecipe() {
    final Future<Map<String, dynamic>> successfulMessage =
        auth.getRecipes("?isPop=default");

    successfulMessage.then((response) {
      if (response['status']) {
        setState(() {
          favRecipes = response['recipes'];
        });
      } else {
        print(response);
      }
    });
  }

  void doGetCategory() {
    final Future<Map<String, dynamic>> successfulMessage =
    auth.getCategories("?sizeSelect=default");

    successfulMessage.then((response) {
      if (response['status']) {
        setState(() {
          categories = response['categories'];
        });
      } else {
        print(response);
      }
    });
  }
}
