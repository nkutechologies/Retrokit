import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:retrokit/app/modules/monitor/views/monitor_view.dart';
import 'package:retrokit/app/modules/selection/views/selection_view.dart';
import 'package:retrokit/styles/colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Container(
            child: PageView(
              controller: controller.pageViewController.value,
              children: [
                MonitorView(),
                SelectionView(),
              ],
              onPageChanged: (index) {
                controller.activePage.value = index;
              },
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 40,
            width: 40,
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: colors.backGround,
              selectedItemColor: colors.green,
              unselectedItemColor: colors.grey,
              currentIndex: controller.activePage.value,
              onTap: (index) {
                controller.pageViewController.value.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
