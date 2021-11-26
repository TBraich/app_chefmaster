import 'package:chefmaster_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/item_category.dart';
import 'package:chefmaster_app/mvvm/models/category.dart';

import 'section_title.dart';

class CategorySlide extends StatefulWidget {
  final List<Category> categories;

  const CategorySlide({Key key, @required this.categories}) : super(key: key);

  @override
  _CategorySlideState createState() => _CategorySlideState();
}

class _CategorySlideState extends State<CategorySlide> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "With Category", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (Category category in widget.categories)
                ItemCategory(category: category),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
