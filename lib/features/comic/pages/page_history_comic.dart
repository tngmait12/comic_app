import 'package:comic_app/features/authentication/pages/page_auth_user.dart';
import 'package:comic_app/features/comic/models/detail_comic.dart';
import 'package:comic_app/features/comic/pages/page_detail_comic.dart';
import 'package:comic_app/my_widget/async_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../my_widget/grid_layout.dart';
import '../../../my_widget/rounded_comic_item.dart';
import '../controller/bookmark_controller.dart';
import '../fetch_api/fetch_comic_by_slug.dart';
import '../models/comic_item.dart';

class PageHistoryComic extends StatelessWidget {
  PageHistoryComic({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Lich su doc truyen",style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: FutureBuilder(
        future: fetchComics(bookmarkController.history),
        builder: (context, snapshot) {
          return AsyncWidget(
            snapshot: snapshot,
            builder: (context, snapshot) {
              List<ComicItem> comics = snapshot.data;

              return GridLayout(
                itemCount: comics.length,
                itemBuilder: (context, index) {
                  final comic = comics[index];
                  return RoundedComicItem(onTap: () => Get.to(PageDetailComic(slug: comic.slug,)),name: comic.name,latestChapter: comic.latestChapter!,imageUrl: comic.thumbUrl,);
                },
              );
            },
          );
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
