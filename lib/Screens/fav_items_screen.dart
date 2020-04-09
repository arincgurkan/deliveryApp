import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/meals.dart';
import '../Widgets/meal_list.dart';

class FavItemScreen extends StatelessWidget {
  Future<void> _refreshCars(BuildContext context) async {
    await Provider.of<Meals>(context, listen: false).getMealsFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _refreshCars(context),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => _refreshCars(context),
                  child: MealList(
                    showFavsOnly: true,
                  ),
                ),
    );
  }
}
