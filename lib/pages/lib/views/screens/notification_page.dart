// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constant/app_color.dart';
import '../../core/model/Notification.dart';
import '../../core/services/NotificationService.dart';
import '../../views/widgets/main_app_bar_widget.dart';
import '../../views/widgets/menu_tile_widget.dart';
import '../../views/widgets/notification_tile.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<UserNotification> listNotification = NotificationService.listNotification;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        cartValue: 2,
        chatValue: 2,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          // Section 1 - Menu
          MenuTileWidget(
            onTap: () {},
            icon: SvgPicture.asset(
              'assets/icons/Discount.svg',
              color: AppColor.secondary.withValues(alpha: 0.5),
            ),
            title: 'Product Promo',
            subtitle: 'Lorem ipsum Dolor sit Amet',
          ),
          MenuTileWidget(
            onTap: () {},
            icon: SvgPicture.asset(
              'assets/icons/Info Square.svg',
              color: AppColor.secondary.withValues(alpha: 0.5),
            ),
            title: 'Marketky Info',
            subtitle: 'Lorem ipsum Dolor sit Amet',
          ),
          // Section 2 - Status ( LIST )
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16, bottom: 8),
                  child: Text(
                    'ORDERS STATUS',
                    style: TextStyle(color: AppColor.secondary.withValues(alpha: 0.5), letterSpacing: 6 / 100, fontWeight: FontWeight.w600),
                  ),
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return NotificationTile(
                      data: listNotification[index],
                      onTap: () {},
                    );
                  },
                  itemCount: listNotification.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
