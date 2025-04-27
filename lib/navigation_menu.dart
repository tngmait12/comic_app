import 'package:comic_app/features/comic/pages/page_favorite_comic.dart';
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
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: Colors.black,
          indicatorColor: Colors.black.withOpacity(0.1),

          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.bookmark_add_outlined), label: 'New Update'),
            NavigationDestination(icon: Icon(Icons.headphones), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Icons.person_off), label: 'Profile'),
          ],
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
    const PageFavoriteComic(),
    const PageSettingComic()
  ];
}