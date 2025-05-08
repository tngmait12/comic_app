import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../authentication/screens/login/login.dart';

class PageFavoriteComic extends StatelessWidget {
  const PageFavoriteComic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark",style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Bạn cần đăng nhập để theo dõi truyện", style: TextStyle(color: Colors.white, fontSize: 32), textAlign: TextAlign.center,),
              ElevatedButton(
                  onPressed: () {
                    Get.to(comic_loginScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Text("Đăng nhập", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
              )
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
