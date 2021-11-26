import 'package:chefmaster_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chefmaster_app/mvvm/views/list_items/list_items_screen.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/enums.dart';


class CategoriesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/fancy-food.svg", "text": "Fancy", "code": 1},
      {"icon": "assets/icons/eat-clean.svg", "text": "Healthy", "code": 2},
      {"icon": "assets/icons/drinks.svg", "text": "Drinks", "code": 3},
      {"icon": "assets/icons/fast-food.svg", "text": "Cheating", "code": 4},
      {"icon": "assets/icons/creative-food.svg", "text": "Creativity", "code": 5},
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              Navigator.pushNamed(context, ListItemsScreen.routeName,
                  arguments: ItemsArguments(
                      categories[index]["text"],
                      ListState.category,
                      "?categoryCode=${categories[index]["code"]}"));
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: kPrimaryColor),
            )
          ],
        ),
      ),
    );
  }
}
