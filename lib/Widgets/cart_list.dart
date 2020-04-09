import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/cart_provider.dart';

class CartList extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  int quantity;
  final String title;

  CartList({
    this.id,
    this.price,
    this.quantity,
    this.title,
    this.productId,
  });

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
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

    return Dismissible(
      key: ValueKey(widget.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      // Sağdan sola kaydırmak için
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the item from the cart?',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  // Bunun içine value yazmak optional ama biz burda yazıyoruz çünkü showDialog bi boolean döndürmesi gerek. Bizde onu burda yapıyoruz
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        // Burda cart'ı dinlemek istemiyoruz. Sadece ulaşmak istiyoruz. Bu yüzden listen: false dedik!
        Provider.of<CartItem>(context, listen: false)
            .removeItem(widget.productId);
      },
      child: Card(
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
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.remove),
                    onTap: () {
                      (widget.quantity == 1)
                          ? () {}
                          : widget.quantity = cartItem.decrementItemQuantity(
                              widget.productId, widget.quantity);
                    },
                  ),
                  Text(widget.quantity.toString()),
                  GestureDetector(
                    child: Icon(Icons.add),
                    onTap: () {
                      widget.quantity = cartItem.incrementItemQuantity(
                          widget.productId, widget.quantity);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
