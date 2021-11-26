import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/loading_indicator.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/mvvm/views/recipe_details/details_screen.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/enums.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class Body extends StatefulWidget {
  final ListState state;
  final String requestParam;
  final double aspectRatio;

  Body({this.state, this.requestParam, this.aspectRatio = 1.0});

  @override
  _BodyState createState() => _BodyState(this.requestParam);
}

class _BodyState extends State<Body> {
  final AuthProvider auth = new AuthProvider();
  List<RecipeDetail> recipes = [];
  final String requestParam;
  bool loadedStatus = false;

  _BodyState(this.requestParam) {
    doGetListRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: doNothing(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              loadedStatus == true) {
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, position) {
                return Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  width: double.maxFinite,
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: Colors.blue,
                  //   ),
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(
                              context, RecipeDetailsScreen.routeName,
                              arguments: RecipeDetailsArguments(
                                  recipeID: recipes[position].recipeId))
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              child: AspectRatio(
                                aspectRatio: widget.aspectRatio,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            recipes[position].coverImageUrl),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: SizedBox(width: 8),
                              flex: 1,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recipes[position].recipeName,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            getProportionateScreenWidth(18)),
                                    maxLines: 1,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      "${recipes[position].creator}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(14),
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Upvote: ",
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(14),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          recipes[position].upvote.toString(),
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(14),
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor,
                                          ),
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey, indent: 15.0,)
                    ],
                  ),
                );
              },
            );
          } else {
            return Align(
              alignment: Alignment.topCenter,
              child: LoadingIndicator(),
            );
          }
        });
  }

  Future<void> doNothing() async {}

  void doGetListRecipes() {
    final Future<Map<String, dynamic>> successfulMessage =
        auth.getRecipes(this.requestParam);

    successfulMessage.then((response) {
      if (response['status']) {
        setState(() {
          recipes = response['recipes'];
          loadedStatus = true;
        });
        print('Success loading data!');
        // return;
      } else {
        print(response);
        // return;
      }
    });
  }
}
