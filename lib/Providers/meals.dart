import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './meal.dart';

class Meals with ChangeNotifier {
  List<Meal> _meals = [
    // Meal(
    //   id: '1',
    //   description: 'Pide. yanında salata ve yeşillikle birlikte servis edilir.',
    //   title: 'Pide',
    //   price: 5.0,
    // ),
    // Meal(
    //   id: '2',
    //   description:
    //       'Adana. yanında salata ve yeşillikle birlikte servis edilir.',
    //   title: 'Adana',
    //   price: 7.0,
    // ),
    // Meal(
    //   id: '3',
    //   description: 'Urfa. yanında salata ve yeşillikle birlikte servis edilir.',
    //   title: 'Urfa',
    //   price: 6.0,
    // ),
  ];

  final String authToken;
  final String userId;

  Meals(
    this.authToken,
    this._meals,
    this.userId,
  );

  List<Meal> get meals {
    return [..._meals];
  }

  Meal findByID(String id) {
    return _meals.firstWhere((meal) => meal.id == id);
  }

  List<Meal> get favoriteItems {
    return _meals.where((mealItem) => mealItem.isFavorite).toList();
  }

  Future<void> getMealsFromDatabase() async {
    var url = 'https://delivery-528c3.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://delivery-528c3.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Meal> loadedMeals = [];
      extractedData.forEach((mealId, mealData) {
        loadedMeals.add(Meal(
          id: mealId,
          title: mealData['title'],
          description: mealData['description'],
          price: mealData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[mealId] ?? false,
        ));
      });
      print('id ' + loadedMeals[0].id);
      _meals = loadedMeals;
      notifyListeners();
    } catch (error) {
      print(error);
      print('Get doenst work');
      throw (error);
    }
  }
}
