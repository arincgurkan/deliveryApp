import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/cart_provider.dart';

class OrderList extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  int quantity;
  final String title;

  OrderList({
    this.id,
    this.price,
    this.quantity,
    this.title,
    this.productId,
  });

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  int incrementQuantity(tempQuantity) {
    setState(() {
      tempQuantity++;
    });
    return tempQuantity;
  }

  int decrementQuantity(tempQuantity) {
    setState(() {
      tempQuantity--;
    });
    return tempQuantity;
  }

  @override
  Widget build(BuildContext context) {
    CartItem cartItem = Provider.of<CartItem>(context);

    return Card(
      key: ValueKey(widget.id),
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$${widget.price}'),
                )),
          ),
          title: Text(widget.title),
          subtitle: Text('Total: \$${(widget.price * widget.quantity)}'),
          trailing: SizedBox(
            width: 60,
            child: Text(widget.quantity.toString()),
          ),
        ),
      ),
    );
  }
}
