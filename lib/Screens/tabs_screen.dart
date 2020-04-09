import 'package:delivery_app/Screens/meals_overview_screen.dart';
import 'package:delivery_app/Screens/shop_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Screens/fav_items_screen.dart';

import '../Providers/cart_provider.dart';
import './profile_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    MealsOverview(),
    FavItemScreen(),
    ShopCartScreen(),
    ProfileScreen(),
  ];

  //Flutter automaticly give that index
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    CartItem cartItem = Provider.of<CartItem>(context);

    return Scaffold(
      appBar: AppBar(
        title: (_selectedPageIndex == 0)
            ? Text('X Restaurant')
            : (_selectedPageIndex == 1)
                ? Text('Favorite Products')
                : (_selectedPageIndex == 2) ? Text('Cart') : Text('Profile'),
        actions: <Widget>[
          (_selectedPageIndex == 0)
              ? SizedBox.shrink()
              : (_selectedPageIndex == 1)
                  ? SizedBox.shrink()
                  : (_selectedPageIndex == 2)
                      ? IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () => cartItem.clear(),
                        )
                      : SizedBox.shrink(),
        ],
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.blue,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          backgroundColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              title: Text('Menu'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favorites'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              title: Text('Cart'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
