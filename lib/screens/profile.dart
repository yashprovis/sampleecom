import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleecom/helpers/methods.dart';
import 'package:sampleecom/provider/tabs_provider.dart';

import 'package:sampleecom/provider/user_provider.dart';
import 'package:sampleecom/screens/address.dart';
import 'package:sampleecom/screens/edit_profile.dart';
import 'package:sampleecom/screens/login.dart';
import 'package:sampleecom/screens/orders.dart';
import 'package:sampleecom/screens/wishlist.dart';
import 'package:sampleecom/widgets/ecom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const List profileItems = [
    {
      "name": "Wishlist",
      "route": WishlistScreen.routeName,
      "icon": CupertinoIcons.heart
    },
    {
      "name": "Orders",
      "route": OrdersScreen.routeName,
      "icon": CupertinoIcons.cube_box
    },
    {
      "name": "Address",
      "route": AddressScreen.routeName,
      "icon": CupertinoIcons.map
    },
    {
      "name": "Logout",
      "route": AddressScreen.routeName,
      "icon": CupertinoIcons.person_badge_minus
    }
  ];

  @override
  Widget build(BuildContext context) {
    TabsProvider tabsProvider = Provider.of<TabsProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ListView(padding: const EdgeInsets.only(top: 20), children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: EcomText(
                  "Profile",
                  size: 20,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(EditProfileScreen.routeName),
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFF080808),
                              borderRadius: BorderRadius.circular(50),
                              image: userProvider.getUser.image == ""
                                  ? null
                                  : DecorationImage(
                                      image: NetworkImage(
                                          userProvider.getUser.image))),
                          child: userProvider.getUser.image == ""
                              ? EcomText(
                                  userProvider.getUser.name
                                      .substring(0, 2)
                                      .toUpperCase(),
                                  color: Colors.white,
                                  size: 20)
                              : null,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 110,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  EcomText(
                                      userProvider.getUser.name.capitalize(),
                                      size: 18),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child:
                                        Icon(Icons.arrow_forward_ios_rounded),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: EcomText(userProvider.getUser.email,
                                    size: 13),
                              ),
                              EcomText(userProvider.getUser.phone, size: 13)
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: profileItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (index == 2) {
                        tabsProvider.changeIndex(0);
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      } else {
                        Navigator.of(context)
                            .pushNamed(profileItems[index]["route"]);
                      }
                    },
                    leading: Icon(profileItems[index]["icon"], size: 30),
                    title: EcomText(profileItems[index]["name"]),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  );
                },
              )
            ])));
  }
}
