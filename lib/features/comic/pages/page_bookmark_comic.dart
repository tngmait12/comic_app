import 'package:comic_app/constants.dart';
import 'package:comic_app/features/authentication/pages/page_auth_user.dart';
import 'package:comic_app/features/comic/pages/page_detail_comic.dart';
import 'package:comic_app/my_widget/async_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../my_widget/grid_layout.dart';
import '../../../my_widget/rounded_comic_item.dart';
import '../controller/bookmark_controller.dart';
import '../fetch_api/fetch_comic_by_slug.dart';
import '../models/comic_item.dart';

class PageBookmarkComic extends StatelessWidget {
    PageBookmarkComic({super.key});

   final bookmarkController = Get.find<BookmarkController>();

    Future<List<ComicItem>> fetchComics(List<Map<String, dynamic>> dataList) async {
      final List<ComicItem> comics = [];

      for (var entry in dataList) {
        final slug = entry['slug'];
        try {
          final comic = await fetchComicBySlug(slug);
          comics.add(comic);
        } catch (e) {
          print("Lỗi khi fetch $slug: $e");
        }
      }

      return comics;
    }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = response?.session != null && response?.user != null;
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark",style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: isLoggedIn
      ? Obx(() {
        final bookmarks = bookmarkController.bookmarks;
        if (bookmarks.isEmpty) {
          return Center(child: Text("Chưa có truyện nào được lưu", style: TextFormat.normal));
        }
        return FutureBuilder(
          future: fetchComics(bookmarks),
          builder: (context, snapshot) {
            return AsyncWidget(
              snapshot: snapshot,
              builder: (context, snapshot) {
                final comics = snapshot.data;

                return SingleChildScrollView(
                  child: GridLayout(
                    itemCount: comics.length,
                    itemBuilder: (context, index) {
                      final comic = comics[index] as ComicItem;
                      return RoundedComicItem(onTap: () => Get.to(PageDetailComic(slug: comic.slug,)),name: comic.name,latestChapter: comic.latestChapter!,imageUrl: comic.thumbUrl,);
                    },
                  ),
                );
              },
            );
          },
        );
      },)
      : Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Bạn cần đăng nhập để theo dõi truyện", style: TextStyle(color: Colors.white, fontSize: 32), textAlign: TextAlign.center,),
              ElevatedButton(
                  onPressed: () {
                    Get.to(PageLoginUser());
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
