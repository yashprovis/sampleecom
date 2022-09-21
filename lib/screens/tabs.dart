import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/provider/order_provider.dart';
import 'package:sampleecom/provider/tabs_provider.dart';
import 'package:sampleecom/screens/random_product.dart';
import '../provider/user_provider.dart';
import '../services/notification_service.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const RandomProducts(),
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
    NotificationService().saveDeviceToken(auth.currentUser!.uid);
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
            selectedItemColor: Color(0xFF080808),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.square_grid_2x2), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.wand_stars), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.cart), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: ""),
            ]));
  }
}
