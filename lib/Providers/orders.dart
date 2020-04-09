import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart_provider.dart';

class Order {
  final String id;
  final String orderNote;
  final double totalAmount;
  final DateTime orderTime;
  final List<Cart> listOfProducts;
  String payType;

  Order(
      {this.id,
      this.orderNote,
      this.totalAmount,
      this.orderTime,
      this.listOfProducts,
      this.payType});
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  final String authToken;
  final String userId;

  Orders(this.authToken, this._orders, this.userId);

  List<Order> get orders {
    return [..._orders];
  }

  // To show order details
  Order findById(String id) {
    return _orders.firstWhere((order) => order.id == id);
  }

  Future<void> addOrder(List<Cart> cartProducts, double total, String orderNote,
      String paymentType) async {
    final url =
        'https://delivery-528c3.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'totalAmount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList(),
          'orderNote': orderNote,
          'paymentType': paymentType,
        }),
      );
      _orders.insert(
        0,
        Order(
          id: json.decode(response.body)['name'],
          totalAmount: total,
          orderTime: timeStamp,
          listOfProducts: cartProducts,
          orderNote: orderNote,
          payType: paymentType,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://delivery-528c3.firebaseio.com/orders/$userId.json?auth=$authToken';
    ;
    final response = await http.get(url);
    final List<Order> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        Order(
          id: orderId,
          totalAmount: orderData['totalAmount'],
          orderTime: DateTime.parse(orderData['dateTime']),
          listOfProducts: (orderData['products'] as List<dynamic>)
              .map((item) => Cart(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title']))
              .toList(),
          payType: orderData['payType'],
          orderNote: 'Some notes',
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
