import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Meal with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  bool isFavorite;

  Meal({
    this.id,
    this.title,
    this.description,
    this.price,
    this.isFavorite = false,
  });

  // If something wents wrong, this will keep old status
  void _setOldStatus(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(
      String authToken, String userId, String mealId) async {
    final oldValue = isFavorite;
    isFavorite = !isFavorite;
    print('meal id in toggleFavoriteStatus : ' + mealId);
    final url =
        'https://delivery-528c3.firebaseio.com/userFavorites/$userId/$mealId.json?auth=$authToken';
    try {
      final response =
          // await http.put(
          //   url,
          //   body: json.encode({mealId: true}),
          // );
          await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setOldStatus(oldValue);
      }
    } catch (error) {
      print('Something went wrong : ' + error);
      _setOldStatus(oldValue);
      // Display the error pop up
    }
    notifyListeners();
  }
}
