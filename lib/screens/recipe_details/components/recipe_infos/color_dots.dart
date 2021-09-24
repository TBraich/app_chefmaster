// import 'package:flutter/material.dart';
// import 'package:chefmaster_app/models/RecipeDetail.dart';
// import 'package:chefmaster_app/utils/size_config.dart';
//
//
// class ColorDots extends StatelessWidget {
//   const ColorDots({
//     Key key,
//     @required this.recipe,
//   }) : super(key: key);
//
//   final RecipeDetail recipe;
//
//   @override
//   Widget build(BuildContext context) {
//     // Now this is fixed and only for demo
//     int selectedColor = 3;
//     return Padding(
//       padding:
//           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//       child: Row(
//         children: [
//           ...List.generate(
//             recipe.colors.length,
//             (index) => ColorDot(
//               color: recipe.colors[index],
//               isSelected: index == selectedColor,
//             ),
//           ),
//           Spacer(),
//           RoundedIconBtn(
//             icon: Icons.remove,
//             press: () {},
//           ),
//           SizedBox(width: getProportionateScreenWidth(20)),
//           RoundedIconBtn(
//             icon: Icons.add,
//             showShadow: true,
//             press: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ColorDot extends StatelessWidget {
//   const ColorDot({
//     Key key,
//     @required this.color,
//     this.isSelected = false,
//   }) : super(key: key);
//
//   final Color color;
//   final bool isSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(right: 2),
//       padding: EdgeInsets.all(getProportionateScreenWidth(8)),
//       height: getProportionateScreenWidth(40),
//       width: getProportionateScreenWidth(40),
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         border:
//             Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
//         shape: BoxShape.circle,
//       ),
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
// }
