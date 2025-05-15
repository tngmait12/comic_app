import 'package:comic_app/features/comic/pages/page_detail_comic.dart';
import 'package:comic_app/my_widget/async_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../my_widget/grid_layout.dart';
import '../../../my_widget/rounded_comic_item.dart';
import '../controller/bookmark_controller.dart';
import '../fetch_api/fetch_comic_by_slug.dart';
import '../fetch_api/fetch_detail_comic.dart';
import '../models/comic_item.dart';
import '../models/detail_comic.dart';

class PageHistoryComic extends StatelessWidget {
  PageHistoryComic({super.key});

  final bookmarkController = Get.find<BookmarkController>();

  Future<List<DetailComic>> fetchComics(List<Map<String, dynamic>> dataList) async {
    final List<DetailComic> comics = [];

    for (var entry in dataList) {
      final slug = entry['slug'];
      try {
        final comic = await fetchDetailComic(slug: slug);
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
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.navigate_before_outlined,
              color: Colors.white,
              size: SIZE_ICO,
            )
        ),
        title: Text("Lịch sử đọc truyện",style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: FutureBuilder(
        future: fetchComics(bookmarkController.history),
        builder: (context, snapshot) {
          return AsyncWidget(
            snapshot: snapshot,
            builder: (context, snapshot) {
              List<DetailComic> comics = snapshot.data;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridLayout(
                    itemCount: comics.length,
                    itemBuilder: (context, index) {
                      final comic = comics[index];
                      return RoundedComicItem(onTap: () => Get.to(PageDetailComic(slug: comic.slug,)),name: comic.name,latestChapter: comic.chapters.last.chapterName,imageUrl: comic.thumbUrl,);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
