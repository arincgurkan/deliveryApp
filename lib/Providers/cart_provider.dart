import 'package:flutter/material.dart';

class Cart {
  final String id;
  final String title;
  final int quantity;
  final double price;

  Cart({this.id, this.title, this.quantity, this.price});
}

// class CartItem with ChangeNotifier {
//   List<Cart> _items = [];

//   List<Cart> get items {
//     return [..._items];
//   }

//   double get totalAmount {
//     var total = 0.0;
//     _items.forEach((cartItem) {
//       total += cartItem.price * cartItem.quantity;
//     });

//     return total;
//   }

//   void addItem(String id, String title, int quantity, double price) {
//     _items.insert(
//       0,
//       Cart(id: id, title: title, quantity: quantity, price: price),
//     );
//     notifyListeners();
//   }
// }

class CartItem with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productID,
    double price,
    String title,
    int quantity,
  ) {
    if (_items.containsKey(productID)) {
      // change quantity...
      _items.update(
        productID,
        (existingCartItem) => Cart(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + quantity,
        ),
      );
    } else {
      _items.putIfAbsent(
        productID,
        () => Cart(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => Cart(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  int incrementItemQuantity(String productId, int tempQuantity) {
    tempQuantity++;
    _items.update(
        productId,
        (existingCartItem) => Cart(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: tempQuantity,
            ));
    notifyListeners();
    return tempQuantity;
  }

  int decrementItemQuantity(String productId, int tempQuantity) {
    tempQuantity--;
    _items.update(
        productId,
        (existingCartItem) => Cart(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: tempQuantity,
            ));
    notifyListeners();
    return tempQuantity;
  }
}
