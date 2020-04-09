import 'package:delivery_app/Screens/tabs_screen.dart';
import 'package:delivery_app/Screens/user_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Screens/meals_overview_screen.dart';
import './Screens/shop_cart_screen.dart';
import './Screens/meals_detail_screen.dart';
import './Providers/cart_provider.dart';
import './Providers/meals.dart';
import './Providers/auth.dart';
import './Screens/splash_screen.dart';
import './Screens/order_confirmation.dart';
import 'Providers/meal.dart';
import './Providers/orders.dart';
import './Screens/order_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: CartItem(),
        ),
        ChangeNotifierProvider.value(
          value: Meal(),
        ),
        ChangeNotifierProxyProvider<Auth, Meals>(
          builder: (ctx, auth, previousMeals) => Meals(auth.token,
              previousMeals == null ? [] : previousMeals.meals, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          builder: (ctx, auth, previousOrders) => Orders(auth.token,
              previousOrders == null ? [] : previousOrders.orders, auth.userId),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: authData.isAuth
              ? TabsScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : UserAuthScreen(),
                ),
          routes: {
            ShopCartScreen.routeName: (ctx) => ShopCartScreen(),
            MealsDetailScreen.routeName: (ctx) => MealsDetailScreen(),
            OrderConfirmation.routeName: (ctx) => OrderConfirmation(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
          },
        ),
      ),
    );
  }
}
