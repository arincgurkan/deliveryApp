import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/order_list.dart';
import '../Providers/cart_provider.dart';
import '../Providers/orders.dart';

class OrderConfirmation extends StatefulWidget {
  static const routeName = '/Order_Confirmation';

  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> listDrop = [];

  String payType;

  void loadData() {
    listDrop = [];
    listDrop.add(
      new DropdownMenuItem(
        child: new Text('Cash'),
        value: 'Cash',
      ),
    );
    listDrop.add(
      new DropdownMenuItem(
        child: new Text('Credit Card'),
        value: 'Credit Card',
      ),
    );
  }

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    CartItem cartItem = Provider.of<CartItem>(context);
    Orders orders = Provider.of<Orders>(context);
    String orderNote;
    loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Order'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: 'Enter your order note!'),
              maxLines: 4,
              controller: myController,
              onChanged: (value) => orderNote = value,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          new DropdownButton(
            items: listDrop,
            value: payType,
            hint: new Text('Select Payment Options'),
            onChanged: (value) {
              payType = value;
              setState(() {});
            },
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                title: Text(
                    'Total amount of your order: €${cartItem.totalAmount}'),
                // subtitle: Text('Total: \$${(widget.price * widget.quantity)}'),
                // trailing: SizedBox(
                //   width: 60,
                //   child: Text(widget.quantity.toString()),
                // ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItem.items.length,
              itemBuilder: (_, index) {
                return OrderList(
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
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(Icons.check),
      //   label: Text('Complete Order!'),
      //   onPressed: () {
      //     orders.addOrder(cartItem.items.values.toList(), cartItem.totalAmount,
      //         orderNote, payType);
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FlatButton(
        child: _isLoading ? CircularProgressIndicator() : Text('Order Now'),
        onPressed: (cartItem.totalAmount <= 0 || _isLoading)
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await orders.addOrder(cartItem.items.values.toList(),
                    cartItem.totalAmount, orderNote, payType);
                setState(() {
                  _isLoading = false;
                });
                cartItem.clear();
                //Navigator.of(context).pushNamed(OrderScreen.routeName);
              },
        textColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
