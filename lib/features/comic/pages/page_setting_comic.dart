import 'package:comic_app/features/comic/pages/page_history_comic.dart';
import 'package:comic_app/features/comic/pages/page_info_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../navigation_menu.dart';
import '../../authentication/pages/page_auth_reset_password.dart';
import '../../authentication/pages/page_auth_user.dart';

class PageSettingComic extends StatelessWidget {
  const PageSettingComic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tài khoản", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: Obx(() =>
        Get.find<AuthController>().response.value?.session != null &&
          Get.find<AuthController>().response.value?.user != null
          ? PageProfileLogined()
          : PageProfileNonLogin(),
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }

  Widget PageProfileNonLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Avatar
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(''),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Chưa đăng nhập",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 15,),
        Divider(),
        SizedBox(height: 15,),
        TextButton.icon(
          onPressed: () {
            Get.to(PageLoginUser());
          },
          icon: Icon(Icons.login, size: 24, color: Colors.blue,),
          label: Text("Đăng nhập", style: TextStyle(fontSize: 24, color: Colors.white),),
        )
      ],
    );
  }

  Widget PageProfileLogined() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Avatar
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(''),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tong Mai Truong Vu",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Level 1",
                    style: TextStyle(fontSize: 18, color: Colors.white54),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 15,),
        Divider(),
        SizedBox(height: 15,),
        TextButton.icon(
          onPressed: () {
            Get.to(() => PageInfoUser());
          },
          icon: Icon(Icons.person, size: 24, color: Colors.blue,),
          label: Text("Thông tin tài khoản", style: TextStyle(fontSize: 24, color: Colors.white),),
        ),
        TextButton.icon(
          onPressed: () {
            Get.to(PageHistoryComic());
          },
          icon: Icon(Icons.history, size: 24, color: Colors.blue,),
          label: Text("Lịch sử đọc truyện", style: TextStyle(fontSize: 24, color: Colors.white),),
        ),
        TextButton.icon(
          onPressed: () {
            Get.to(PageResetPassword());
          },
          icon: Icon(Icons.lock, size: 24, color: Colors.blue,),
          label: Text("Đổi mật khẩu", style: TextStyle(fontSize: 24, color: Colors.white),),
        ),
        TextButton.icon(
          onPressed: () {
            Get.find<AuthController>().logout();
            Get.snackbar(
              "Đăng xuất thành công",
              "Bạn đã đăng xuất khỏi hệ thống",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: Duration(seconds: 2),
            );
          },
          icon: Icon(Icons.logout, size: 24, color: Colors.blue,),
          label: Text("Đăng xuất", style: TextStyle(fontSize: 24, color: Colors.white),),
        )
      ],
    );
  }
}
