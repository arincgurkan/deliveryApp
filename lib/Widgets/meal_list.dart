import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './meal_item.dart';
import '../Providers/meals.dart';

class MealList extends StatelessWidget {
  bool showFavsOnly;

  MealList({this.showFavsOnly});

  @override
  Widget build(BuildContext context) {
    Meals mealsData = Provider.of<Meals>(context);
    final meals = showFavsOnly ? mealsData.favoriteItems : mealsData.meals;

    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (_, index) => ChangeNotifierProvider.value(
        value: meals[index],
        child: MealItem(),
      ),
    );
  }
}
