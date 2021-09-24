import 'package:flutter/material.dart';
import 'package:chefmaster_app/models/Category.dart';
import 'package:chefmaster_app/screens/list_items/list_items_screen.dart';
import 'package:chefmaster_app/utils/enums.dart';

import '../utils/constants.dart';
import '../utils/size_config.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.category,
  }) : super(key: key);

  final double width, aspectRetio;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ListItemsScreen.routeName,
                arguments: ItemsArguments(category.name, ListState.category,
                    "?categoryCode=${category.code}"));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: aspectRetio,
                child: Container(
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: NetworkImage(category.imageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(14)),
                maxLines: 1,
              ),
              Text(
                category.description,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: getProportionateScreenWidth(10)),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
