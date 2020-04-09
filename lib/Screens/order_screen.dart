import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/orders.dart';
import '../Widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order_screen';

  @override
  Widget build(BuildContext context) {
    Orders orders = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: orders.fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              //Do error handling
              return Center(
                child: Text('An error occured'),
              );
            } else {
              // Burda consumer kullanmayıp yukarda provider la yapsakdık infinite loop a girecektik
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (context, index) =>
                      OrderItem(orderData.orders[index]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
