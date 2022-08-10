import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/constants.dart';
import 'package:sampleecom/provider/order_provider.dart';
import 'package:sampleecom/provider/tabs_provider.dart';
import '../provider/user_provider.dart';
import 'cart.dart';
import 'home.dart';
import 'profile.dart';
import 'wishlist.dart';
import 'category.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = "/tabs";
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    await userProvider.refreshUser();
    await orderProvider.fetchCurrentOrders();
  }

  @override
  Widget build(BuildContext context) {
    TabsProvider tabs = Provider.of<TabsProvider>(context);
    return Scaffold(
        body: screens[tabs.index],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabs.index,
            onTap: (index) {
              tabs.changeIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.storefront_sharp), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: ""),
            ]));
  }
}
