import 'package:flutter/material.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class RecipeImages extends StatefulWidget {
  final double height;
  RecipeImages({
    Key key,
    @required this.recipe, this.height,
  }) : super(key: key);

  final RecipeDetail recipe;

  @override
  _RecipeImagesState createState() => _RecipeImagesState();
}

class _RecipeImagesState extends State<RecipeImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.recipe.detailImageUrl[selectedImage].url),
          fit: BoxFit.cover,
        ),
      ),
      child: SizedBox(
        width: SizeConfig.screenWidth,
        height: widget.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.recipe.detailImageUrl.length,
                    (index) => buildSmallRecipePreview(index)),
          ],
        ),
      ),
    );
  }

  GestureDetector buildSmallRecipePreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        // padding: EdgeInsets.all(4),
        height: getProportionateScreenWidth(49),
        width: getProportionateScreenWidth(49),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.recipe.detailImageUrl[index].url,
            height: getProportionateScreenWidth(48),
            width: getProportionateScreenWidth(48),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
