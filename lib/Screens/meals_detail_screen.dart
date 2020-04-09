import 'package:delivery_app/Providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/meals.dart';
import '../Providers/meal.dart';
import '../Widgets/meal_detail.dart';

class MealsDetailScreen extends StatelessWidget {
  static const routeName = '/meals-detail-screen';

  var _mealDetail = Meal(
    id: '',
    title: '',
    description: '',
    price: null,
    isFavorite: false,
  );

  @override
  Widget build(BuildContext context) {
    Meals meals = Provider.of<Meals>(context);
    Meal meal = Provider.of<Meal>(context);
    final authData = Provider.of<Auth>(context, listen: false);

    final args = ModalRoute.of(context).settings.arguments;
    _mealDetail = meals.findByID(args);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
        actions: <Widget>[
          IconButton(
            icon: _mealDetail.isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            onPressed: () {
              print('favorite status ' + (_mealDetail.isFavorite).toString());
              print('meal id in meal detal screen : ' + args);
              meal.toggleFavoriteStatus(authData.token, authData.userId, args);
            },
          ),
        ],
      ),
      body: MealDetail(
        id: _mealDetail.id,
        title: _mealDetail.title,
        description: _mealDetail.description,
        price: _mealDetail.price,
        isFavorite: _mealDetail.isFavorite,
      ),
    );
  }
}
