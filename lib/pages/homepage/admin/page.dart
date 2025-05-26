// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/foundation.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/users/login2/login.dart';
import 'package:ljm/main.dart';
import 'package:ljm/provider/models/user.dart';
import 'package:ljm/provider/models/dashboard/top.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/tools/notifications.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'controller.dart';
import 'widgets/chart.dart';

part 'events.dart';
part 'widgets.dart';
part 'widgets/drawer.dart';
part 'widgets/menugrid.dart';
part 'widgets/top10.dart';

class DBAdmin extends GetView<DBAdminController> {
  final User user;
  const DBAdmin(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (b) => showExitPopup(context),
      child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(skala)),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: Obx(
              () => // controller.isProses.value ? showloading():
                  Scaffold(
                drawer: drawer(context, (i) => _onTapDrawer(i)),
                //drawer: _drawer(this),
                appBar: AppBar(
                    elevation: 0,
                    title: (kIsWeb)
                        ? Text("Lucky Jaya Group ${(iDireksi() ? 'Direksi' : 'Admin')}")
                        : Text(
                            "Lucky Jaya Group ${(iDireksi() ? 'Direksi' : 'Admin')}",
                          ),
                    actions: [
                      controller.isProsesDashboard.value ? showLoading3() : Padding(padding: const EdgeInsets.only(right: 30.0), child: GestureDetector(onTap: () => controller.getData(true), child: const Icon(Icons.refresh))),
                    ]),
                body: /* controller.isLoading.value
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          showLoading3(),
                          Obx(() => Text("${controller.trigger.value} dbc.prosesText.value")),
                        ],
                      ))
                    :  */
                    _body(context, controller),
                /* GetBuilder<DBAdminController>(
              builder: (_) => controller.isProses.isTrue ? const ShowLoading4() : _body(context, controller),
            ), */
              ),
            ),
          )),
    );
  }

  _body(BuildContext context, DBAdminController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.getData(true),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 200, child: _top10(controller)),
            _btnTransaksi(controller),
            const SizedBox(height: 15),
            SizedBox(height: 300, child: _menuGrid(controller)),
            /*  _listWidget("Penjualan", formatangka(dashb.total.toString())),
                      Container(height: 100, color: Colors.red[100]),
                      Container(height: 200, color: Colors.yellow[100]),
                      const Text('Footer'), */
          ],
        ),
      ),
    );
  }
}
