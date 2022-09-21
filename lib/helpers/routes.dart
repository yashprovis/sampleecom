import 'package:flutter/material.dart';
import 'package:sampleecom/models/product_model.dart';
import 'package:sampleecom/screens/forgot_password.dart';

import 'package:sampleecom/screens/login.dart';
import 'package:sampleecom/screens/order_placed.dart';

import 'package:sampleecom/screens/register.dart';
import 'package:sampleecom/screens/tabs.dart';
import 'package:sampleecom/screens/wishlist.dart';

import '../screens/address.dart';
import '../screens/checkout.dart';
import '../screens/edit_profile.dart';
import '../screens/order_detail.dart';
import '../screens/orders.dart';
import '../screens/product_detail.dart';
import '../screens/product_list.dart';
import '../screens/product_ratings.dart';
import '../screens/search.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case TabsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const TabsScreen(),
        );
      case ProductListScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => ProductListScreen(args: args as Map),
        );
      case RatingsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => RatingsScreen(args: args as Map),
        );
      case ProductDetailScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => ProductDetailScreen(productId: args as String),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case WishlistScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const WishlistScreen(),
        );
      case CheckoutScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => CheckoutScreen(products: args as List<Product>),
        );
      case EditProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      case AddressScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const AddressScreen(),
        );
      case OrdersScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const OrdersScreen(),
        );
      case OrderPlaced.routeName:
        return MaterialPageRoute(
          builder: (context) => OrderPlaced(orderId: args as String),
        );
      case OrderDetail.routeName:
        return MaterialPageRoute(
          builder: (context) => OrderDetail(orderId: args as String),
        );
      case SearchScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('ERROR')),
          body: const Center(
            child: Text("Page not found"),
          ),
        );
      },
    );
  }
}
