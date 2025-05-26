// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ljm/pages/lib/constant/app_color.dart';
import 'package:ljm/pages/lib/core/model/Category.dart';
import 'package:ljm/pages/lib/core/model/Product.dart';
import 'package:ljm/pages/lib/core/services/CategoryService.dart';
import 'package:ljm/pages/lib/core/services/ProductService.dart';
import 'package:ljm/pages/lib/views/screens/message_page.dart';
import 'package:ljm/pages/lib/views/screens/search_page.dart';
import 'package:ljm/pages/lib/views/widgets/category_card.dart';
import 'package:ljm/pages/lib/views/widgets/custom_icon_button_widget.dart';
import 'package:ljm/pages/lib/views/widgets/dummy_search_widget_1.dart';
import 'package:ljm/pages/lib/views/widgets/flashsale_countdown_tile.dart';
import 'package:ljm/pages/lib/views/widgets/item_card.dart';
import 'package:ljm/pages/users/login2/login.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/tools/env.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _BeerListViewState();
}

class _BeerListViewState extends State<HomePage> {
  List<Category> categoryData = CategoryService.categoryData;
  List<Product> productData = ProductService.productData;

  late Timer flashsaleCountdownTimer;
  Duration flashsaleCountdownDuration = Duration(
    hours: 24 - DateTime.now().hour,
    minutes: 60 - DateTime.now().minute,
    seconds: 60 - DateTime.now().second,
  );

  void startTimer() {
    flashsaleCountdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setCountdown();
    });
  }

  bool errorBARANG = false;
  static const _pageSize = 20;
  var semua = <BARANG>[];
  void setCountdown() {
    if (mounted) {
      setState(() {
        final seconds = flashsaleCountdownDuration.inSeconds - 1;

        if (seconds < 1) {
          flashsaleCountdownTimer.cancel();
        } else {
          flashsaleCountdownDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  late final PagingController<int, BARANG> pagingController = PagingController<int, BARANG>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  initData() async {
    //
  }

  Future<List<BARANG>> fetchPage(int pageKey) async {
    //var start = pageKey + _pageSize;
    var until = pageKey + _pageSize;
    if (semua.isEmpty) {
      /*  var res = await dBase.rawQuery("select bj.jenis nama, group_concat(b.merk, ', ') merk, min(jual5) jual4, max(jual5) jual5, sum(stok) stok from v_barang b  inner join brgjenis bj on bj.id = b.idjenis where b.aktif = 1 and bj.aktif =1 group by bj.jenis");
      semua = res.isNotEmpty ? res.map((c) => BARANG.fromMap(c)).toList() : []; */
    }
    if (until > semua.length) until = semua.length;
    try {
      var newItems = semua.sublist(pageKey, until).toList();
      return newItems;
    } catch (e) {
      dp('error Loading $e');
      dp('pageKey $pageKey');
      // dp('start $start until $until');
      return [];
      // errorBARANG = true;
      //await dbc.initMasterBARANG();
      //errorBARANG = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    String seconds = flashsaleCountdownDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String minutes = flashsaleCountdownDuration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String hours = flashsaleCountdownDuration.inHours.remainder(24).toString().padLeft(2, '0');
    return Scaffold(
        body: CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          // section 1
          Container(
            height: 190,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.jpg'),
                // image: AssetImage('assets/play_store_512.png'),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 26),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lucky Jaya Motorindo \nSparepart.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          height: 150 / 100,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Row(
                        children: [
                          /* CustomIconButtonWidget(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EmptyCartPage()));
                              },
                              value: 0,
                              icon: SvgPicture.asset(
                                'assets/icons/Bag.svg',
                                color: Colors.white,
                              ),
                            ), */
                          CustomIconButtonWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MessagePage()));
                            },
                            value: 2,
                            margin: const EdgeInsets.only(left: 4),
                            icon: SvgPicture.asset('assets/icons/Chat.svg', color: Colors.white),
                          ),
                          CustomIconButtonWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                            },
                            value: 0,
                            margin: const EdgeInsets.only(left: 4),
                            icon: SvgPicture.asset('assets/icons/user.svg', width: 20, height: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DummySearchWidget1(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // ListView
          // Section 2 - category
          Container(
            width: MediaQuery.of(context).size.width,
            color: AppColor.secondary,
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Category', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(foregroundColor: Colors.white),
                        child: Text('View More', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
                // Category list
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  height: 96,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: categoryData.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 16);
                    },
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        data: categoryData[index],
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Section 4 - Flash Sale
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Flash Sale',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: hours[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: hours[1],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 2.0),
                            child: Text(
                              ':',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: minutes[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: minutes[1],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 2.0),
                            child: Text(
                              ':',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: seconds[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: seconds[1],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 320,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            productData.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ItemCard(
                                    product: productData[index],
                                    titleColor: AppColor.primarySoft,
                                    priceColor: AppColor.accent,
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: const LinearProgressIndicator(
                                                minHeight: 10,
                                                value: 0.4,
                                                color: AppColor.accent,
                                                backgroundColor: AppColor.border,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.local_fire_department,
                                          color: AppColor.accent,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         color: Colors.amber,
                                  //         height: 10,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ])),
        const SliverAppBar(
          elevation: 0,
          backgroundColor: AppColor.accent,
          pinned: true,
          title: Text('Daftar Produk'),
          actions: [],
        ),
        /* (errorBARANG)
            ? SliverList(delegate: SliverChildListDelegate([Obx(() => contentBox(title: "dbc.prosesText.value"))]))
            : PagedSliverGrid(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<BARANG>(
                  itemBuilder: (context, item, index) => ItemBARANG(barang: item),
                ),
                // ignore: prefer_const_constructors
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom
                  mainAxisSpacing: 10.0, // Spasi antara item secara vertikal
                  crossAxisSpacing: 10.0, // Spasi antara item secara horizontal
                  childAspectRatio: 1.0, //Rasio tinggi lebar item
                  mainAxisExtent: 250,
                ),
              ), */
        /*
        PagedSliverList<int, BARANG>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<BARANG>(
            itemBuilder: (context, item, index) => ItemBARANG(barang: item),
          ),
        ), */
      ],
    ));
  }

  @override
  void dispose() {
    pagingController.dispose();
    flashsaleCountdownTimer.cancel();
    super.dispose();
  }
}

/*
// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/lib/controller.dart';
import 'package:ljm/pages/lib/views/screens/jenis.dart';
import 'package:ljm/pages/lib/views/widgets/category_card.dart';
import 'package:ljm/pages/lib/views/widgets/item_barang.dart';
import 'package:ljm/pages/users/login2/login.dart';
import 'package:ljm/tools/env.dart';
import '../../constant/app_color.dart';
import '../../core/model/Category.dart';
import '../../core/model/Product.dart';
import '../../core/services/CategoryService.dart';
import '../../core/services/ProductService.dart';
import '../../views/screens/message_page.dart';
import '../../views/screens/search_page.dart';
import '../../views/widgets/custom_icon_button_widget.dart';
import '../../views/widgets/dummy_search_widget_1.dart';
import '../../views/widgets/flashsale_countdown_tile.dart';
import '../../views/widgets/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categoryData = CategoryService.categoryData;
  List<Product> productData = ProductService.productData;

  late Timer flashsaleCountdownTimer;
  Duration flashsaleCountdownDuration = Duration(
    hours: 24 - DateTime.now().hour,
    minutes: 60 - DateTime.now().minute,
    seconds: 60 - DateTime.now().second,
  );
  late DBMain2Controller c;
  @override
  void initState() {
    c = Get.find<DBMain2Controller>();
    super.initState();
    startTimer();
  }

  void startTimer() {
    flashsaleCountdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setCountdown();
    });
  }

  void setCountdown() {
    if (mounted) {
      setState(() {
        final seconds = flashsaleCountdownDuration.inSeconds - 1;

        if (seconds < 1) {
          flashsaleCountdownTimer.cancel();
        } else {
          flashsaleCountdownDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  void dispose() {
    flashsaleCountdownTimer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String seconds = flashsaleCountdownDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String minutes = flashsaleCountdownDuration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String hours = flashsaleCountdownDuration.inHours.remainder(24).toString().padLeft(2, '0');

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      child: Scaffold(
          body: /* ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            // Section 1
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 26),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lucky Jaya Motorindo \nSparepart.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            height: 150 / 100,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Row(
                          children: [
                            /* CustomIconButtonWidget(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EmptyCartPage()));
                              },
                              value: 0,
                              icon: SvgPicture.asset(
                                'assets/icons/Bag.svg',
                                color: Colors.white,
                              ),
                            ), */
                            CustomIconButtonWidget(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MessagePage()));
                              },
                              value: 2,
                              margin: const EdgeInsets.only(left: 4),
                              icon: SvgPicture.asset(
                                'assets/icons/Chat.svg',
                                color: Colors.white,
                              ),
                            ),
                            CustomIconButtonWidget(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                              },
                              value: 0,
                              margin: const EdgeInsets.only(left: 4),
                              icon: SvgPicture.asset(
                                'assets/icons/user.svg',
                                width: 20,
                                height: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DummySearchWidget1(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Section 2 - category
            Container(
              width: MediaQuery.of(context).size.width,
              color: AppColor.secondary,
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Category', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(foregroundColor: Colors.white),
                          child: Text('View More', style: TextStyle(color: Colors.white.withValues(alpha:0.7), fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                  // Category list
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    height: 96,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categoryData.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 16);
                      },
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          data: categoryData[index],
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Section 3 - banner
            Container(
              color: AppColor.primary,
              height: 100,
              width: 80,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const JenisPanel(), /* ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 16);
                },
                itemBuilder: (context, index) {
                  return Container(
                    width: 230,
                    height: 106,
                    decoration: BoxDecoration(color: AppColor.primarySoft, borderRadius: BorderRadius.circular(15)),
                  );
                },
              ), */
            ),

            // Section 4 - Flash Sale
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Flash Sale',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: FlashsaleCountdownTile(
                                digit: hours[0],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: FlashsaleCountdownTile(
                                digit: hours[1],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 2.0),
                              child: Text(
                                ':',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: FlashsaleCountdownTile(
                                digit: minutes[0],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: FlashsaleCountdownTile(
                                digit: minutes[1],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 2.0),
                              child: Text(
                                ':',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: FlashsaleCountdownTile(
                                digit: seconds[0],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: FlashsaleCountdownTile(
                                digit: seconds[1],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 320,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              productData.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ItemCard(
                                      product: productData[index],
                                      titleColor: AppColor.primarySoft,
                                      priceColor: AppColor.accent,
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: const LinearProgressIndicator(
                                                  minHeight: 10,
                                                  value: 0.4,
                                                  color: AppColor.accent,
                                                  backgroundColor: AppColor.border,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.local_fire_department,
                                            color: AppColor.accent,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       child: Container(
                                    //         color: Colors.amber,
                                    //         height: 10,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Section 5 - product list

            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Todays recommendation...',
                style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),

            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(c.barang.length + 1, (index) {
                    if (index >= c.barang.length) {
                      if (!c._isLoading) {
                        c.addata();
                      }
                      return Text("halaman: ${c.page.value}");
                    } else {
                      return ItemBARANG(barang: c.barang[index]);
                    }
                  }),
                ),
              ),
            ), */
              Column(
        children: [
          Obx(() => Text("halaman: ${c.page.value}/trigger:${c.page.value}")),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: c.barang.length + 1, // Tambahkan satu item untuk indikator loading
                itemBuilder: (context, index) {
                  if (index >= c.barang.length) {
                    if (!c._isLoading) {
                      c.addata();
                    }
                    return Text("halaman: ${c.page.value}/trigger:${c.page.value}");
                  } else {
                    return ItemBARANG(barang: c.barang[index]);
                  }
                },
              ),
            ),
          ),
        ],
      )

          //  ],        ),
          ),
    );
  }
}
*/
