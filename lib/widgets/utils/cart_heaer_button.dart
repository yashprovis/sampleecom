import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sampleecom/provider/tabs_provider.dart';

import '../../constants.dart';
import '../../provider/user_provider.dart';
import '../ecom_text.dart';

class CartHeaderButton extends StatelessWidget {
  final double? size;
  final void Function()? func;
  final Color? color;
  const CartHeaderButton({Key? key, this.size, this.color, this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: func ??
          () {
            context.read<TabsProvider>().changeIndex(3);
          },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: size == null ? 10 : 6),
            child: Icon(CupertinoIcons.cart, size: size ?? 32, color: color),
          ),
          userProvider.getUser.cart == null
              ? const SizedBox()
              : Positioned(
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: color ?? primaryColor,
                    radius: size == null ? 8 : 6,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: EcomText(
                          userProvider.getUser.cart!.length.toString(),
                          size: size == null ? 10 : 8,
                          color: color != null ? primaryColor : Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
