import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Providers/orders.dart' as oFromProvider;

class OrderItem extends StatefulWidget {
  final oFromProvider.Order order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.totalAmount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget.order.orderTime),
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            // min accepts double
            Container(
              height: min(widget.order.listOfProducts.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.listOfProducts
                    .map((prod) => Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Text(
                              //   '${prod.quantity}x \$${prod.price}',
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //     color: Colors.grey,
                              //   ),
                              // )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
