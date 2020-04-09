import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/auth.dart';
import './order_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    return Column(
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.payment),
            title: Text('Order History'),
            onTap: () {
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              auth.logout();
            }),
        Divider(),
      ],
    );
  }
}
