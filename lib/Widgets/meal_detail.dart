import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/cart_provider.dart';

class MealDetail extends StatefulWidget {
  final String id;
  final String description;
  final String title;
  final double price;
  bool isFavorite;

  MealDetail(
      {this.id, this.title, this.description, this.price, this.isFavorite});

  @override
  _MealDetailState createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  int itemCount = 1;

  void _incrementCounter() {
    setState(() {
      itemCount++;
    });
  }

  void _decrementCounter() {
    setState(() {
      itemCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    double newPrice = widget.price;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.title),
              SizedBox(
                height: 5,
              ),
              Text(widget.description),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: (itemCount == 1) ? Colors.grey : Colors.black,
                        ),
                        onPressed:
                            (itemCount == 1) ? () => {} : _decrementCounter,
                      ),
                      Text(itemCount.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _incrementCounter,
                      ),
                    ],
                  ),
                  Text('€' + (newPrice * itemCount).toString()),
                ],
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 40,
                  child: Center(
                    child: Text(
                      'Add to Cart',
                    ),
                  ),
                ),
                onTap: () => {
                  Navigator.of(context).pop(),
                  Provider.of<CartItem>(context)
                      .addItem(widget.id, newPrice, widget.title, itemCount),
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
