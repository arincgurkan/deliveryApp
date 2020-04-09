import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/meal.dart';

import '../Screens/meals_detail_screen.dart';

class MealItem extends StatelessWidget {
  // final String title;
  // final String description;
  // final double price;
  // final String id;

  // MealItem({this.title, this.description, this.price, this.id});

  @override
  Widget build(BuildContext context) {
    final meal = Provider.of<Meal>(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.add),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(meal.title),
                      Text('\€${meal.price}'),
                    ],
                  ),
                  Container(width: 280, child: Text(meal.description)),
                ],
              ),
            ),
            onTap: () => Navigator.of(context)
                .pushNamed(MealsDetailScreen.routeName, arguments: meal.id),
          ),
          Divider(),
        ],
      ),
    );
  }
}
