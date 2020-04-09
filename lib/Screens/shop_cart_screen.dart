import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/cart_provider.dart';
import '../Widgets/cart_list.dart';
import './order_confirmation.dart';

class ShopCartScreen extends StatelessWidget {
  static const routeName = '/shop-cart-screen';

  @override
  Widget build(BuildContext context) {
    CartItem cartItem = Provider.of<CartItem>(context);
    return Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              // Bu Row un children larını birbirinden ayırmak için
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                // Spacer widget takes spaces all it can get
                Spacer(),
                Chip(
                  label: Text(
                    '\$${cartItem.totalAmount.toString()}',
                    style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Chip(
                  label: GestureDetector(
                    child: Text(
                      'Order Now!',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title.color),
                    ),
                    onTap: () => (cartItem.totalAmount > 0)
                        ? Navigator.pushNamed(
                            context,
                            OrderConfirmation.routeName,
                          )
                        : {},
                  ),
                  backgroundColor: (cartItem.totalAmount > 0)
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cartItem.items.length,
            itemBuilder: (_, index) {
              return CartList(
                id: cartItem.items.values.toList()[index].id,
                productId: cartItem.items.keys.toList()[index],
                title: cartItem.items.values.toList()[index].title,
                price: cartItem.items.values.toList()[index].price,
                quantity: cartItem.items.values.toList()[index].quantity,
              );
            },
          ),
        ),
      ],
    );
  }
}
