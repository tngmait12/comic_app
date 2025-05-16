import 'package:comic_app/features/comic/pages/page_bookmark_comic.dart';
import 'package:comic_app/features/comic/pages/page_home_comic.dart';
import 'package:comic_app/features/comic/pages/page_new_comic.dart';
import 'package:comic_app/features/comic/pages/page_setting_comic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBarTheme(
              data: NavigationBarThemeData(
                labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                      (states) {
                    if (states.contains(MaterialState.selected)) {
                      return const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      );
                    } else {
                      return const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.normal,
                      );
                    }
                  },
                ),
              ),
              child: NavigationBar(
                  height: 80,
                  elevation: 0,
                  selectedIndex: controller.selectedIndex.value,
                  onDestinationSelected: (index) => controller.selectedIndex.value = index,
                  backgroundColor: Colors.black,
                  indicatorColor: Colors.white.withOpacity(0.1),
                  // labelTextStyle: MaterialStateProperty.all(
                  //   TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
                  destinations: const [
                    NavigationDestination(icon: Icon(Icons.home, color: Colors.white,), label: 'Trang chủ'),
                    NavigationDestination(icon: Icon(Icons.update, color: Colors.white), label: 'Mới cập nhật'),
                    NavigationDestination(icon: Icon(Icons.bookmark, color: Colors.white), label: 'Bookmark'),
                    NavigationDestination(
                        icon: Icon(Icons.account_circle, color: Colors.white),
                        label: "Tài khoản"),
                  ],
              ),
            ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const PageHomeComic(),
    const PageNewComic(),
     PageBookmarkComic(),
    const PageSettingComic()
  ];
}