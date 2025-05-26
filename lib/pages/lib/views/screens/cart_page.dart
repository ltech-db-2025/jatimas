// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constant/app_color.dart';
import '../../core/model/Cart.dart';
import '../../core/services/CartService.dart';
import '../../views/screens/order_success_page.dart';
import '../../views/widgets/cart_tile.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> cartData = CartService.cartData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            const Text('Your Cart', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
            Text('3 items', style: TextStyle(fontSize: 10, color: Colors.black.withValues(alpha: 0.7))),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: AppColor.primarySoft,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      // Checkout Button
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColor.border, width: 1))),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrderSuccessPage()));
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                flex: 6,
                child: Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18, fontFamily: 'poppins'),
                ),
              ),
              Container(
                width: 2,
                height: 26,
                color: Colors.white.withValues(alpha: 0.5),
              ),
              const Flexible(
                flex: 6,
                child: Text(
                  'Rp 10,429,000',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CartTile(
                data: cartData[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: 3,
          ),
          // Section 2 - Shipping Information
          Container(
            margin: const EdgeInsets.only(top: 24),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: AppColor.primarySoft,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.border, width: 1),
            ),
            child: Column(
              children: [
                // header
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Shipping information',
                        style: TextStyle(fontSize: 14, fontFamily: 'poppins', fontWeight: FontWeight.w600, color: AppColor.secondary),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColor.primary,
                          shape: const CircleBorder(),
                          backgroundColor: AppColor.border,
                          elevation: 0,
                          padding: const EdgeInsets.all(0),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/Pencil.svg',
                          width: 16,
                          color: AppColor.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Name
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: SvgPicture.asset('assets/icons/Profile.svg', width: 18),
                      ),
                      Expanded(
                        child: Text(
                          'Arnold Utomo',
                          style: TextStyle(
                            color: AppColor.secondary.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Address
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: SvgPicture.asset('assets/icons/Home.svg', width: 18),
                      ),
                      Expanded(
                        child: Text(
                          '1281 90 Trutomo Street, New York, United States ',
                          style: TextStyle(
                            color: AppColor.secondary.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Phone Number
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: SvgPicture.asset('assets/icons/Profile.svg', width: 18),
                    ),
                    Expanded(
                      child: Text(
                        '0888 - 8888 - 8888',
                        style: TextStyle(
                          color: AppColor.secondary.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Section 3 - Select Shipping method
          Container(
            margin: const EdgeInsets.only(top: 24),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.border, width: 1),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: AppColor.primarySoft,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  // Content
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select Shipping method', style: TextStyle(color: AppColor.secondary.withValues(alpha: 0.7), fontSize: 10)),
                          const Text('Official Shipping', style: TextStyle(color: AppColor.secondary, fontWeight: FontWeight.w600, fontFamily: 'poppins')),
                        ],
                      ),
                      const Text('free delivery', style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 4,
                              child: Text(
                                'Shipping',
                                style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.secondary),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                '3-5 Days',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColor.secondary.withValues(alpha: 0.7)),
                              ),
                            ),
                            const Expanded(
                              flex: 4,
                              child: Text(
                                'Rp 0',
                                textAlign: TextAlign.end,
                                style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: 4,
                            child: Text(
                              'Subtotal',
                              style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.secondary),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              '4 Items',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColor.secondary.withValues(alpha: 0.7)),
                            ),
                          ),
                          const Expanded(
                            flex: 4,
                            child: Text(
                              'Rp 1,429,000',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
