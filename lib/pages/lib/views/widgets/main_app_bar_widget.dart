// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constant/app_color.dart';
import '../../views/screens/cart_page.dart';
import '../../views/screens/message_page.dart';
import '../../views/screens/search_page.dart';
import '../../views/widgets/custom_icon_button_widget.dart';
import '../../views/widgets/dummy_search_widget2.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int cartValue;
  final int chatValue;

  const MainAppBar({
    super.key,
    required this.cartValue,
    required this.chatValue,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: AppColor.primary,
      elevation: 0,
      title: Row(
        children: [
          DummySearchWidget2(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
          ),
          CustomIconButtonWidget(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartPage()));
            },
            value: widget.cartValue,
            margin: const EdgeInsets.only(left: 16),
            icon: SvgPicture.asset(
              'assets/icons/Bag.svg',
              color: Colors.white,
            ),
          ),
          CustomIconButtonWidget(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MessagePage()));
            },
            value: widget.chatValue,
            margin: const EdgeInsets.only(left: 16),
            icon: SvgPicture.asset(
              'assets/icons/Chat.svg',
              color: Colors.white,
            ),
          ),
        ],
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
