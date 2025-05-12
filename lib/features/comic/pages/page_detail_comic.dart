import 'package:comic_app/constants.dart';
import 'package:comic_app/features/comic/controller/detail_comic_controller.dart';
import 'package:comic_app/features/comic/fetch_api/fetch_detail_comic.dart';
import 'package:comic_app/features/comic/models/chapter_item.dart';
import 'package:comic_app/features/comic/models/detail_comic.dart';
import 'package:comic_app/features/comic/pages/page_chapter_comic.dart';
import 'package:comic_app/my_widget/async_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bookmark_controller.dart';

class PageDetailComic extends StatelessWidget {
  PageDetailComic({super.key, required this.slug});

  final String slug;
  final GlobalKey _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final DetailComicController controller = Get.put(DetailComicController());
    final bookmarkController = Get.find<BookmarkController>();

    return FutureBuilder(
      future: fetchDetailComic(slug: slug),
      builder: (context, snapshot) {

        return AsyncWidget(
          snapshot: snapshot,
          builder: (context, snapshot) {
            DetailComic comic = snapshot.data;
            List<ChapterItem> chapters = comic.chapters.reversed.toList();

            return Obx(
              () {
                controller.getContainerWidth(_containerKey);
                controller.checkTextOverflow(text: comic.content, style: TextFormat.normal, maxLines: 2);
                
                var chapterInHistory = bookmarkController.history.firstWhere((e) => slug == e['slug'], orElse: () => <String, dynamic>{},);
                
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
                    backgroundColor: Theme.of(context).colorScheme.shadow
                  ),
                  body: SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
    
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network("https://otruyenapi.com/uploads/comics/${comic.thumbUrl}",
                                      fit: BoxFit.cover,
                                      width: WIDTH_IMG,
                                    ),
                                  ),
    
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              comic.name,
                                              style: TextFormat.title,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
    
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.all(Radius.circular(BORDER_RAD))
                                                  ),
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    comic.status,
                                                    style: TextStyle(
                                                        color: WHITE,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
    
    
                              HEIGHT_PAD,
    
                              // button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.to(PageChapterComic(chapterItem: (controller.chapterInHistory.value != null) ? controller.chapterInHistory.value!
                                        : chapters.last, listChapter: chapters, slug: comic.slug));
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.cyan),
                                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0,
                                          vertical: 8.0
                                      ),
                                      child: Text(
                                        (controller.chapterInHistory.value == null)
                                            ? "Đọc ngay"
                                            : "Đọc tiếp",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      bookmarkController.toggleBookmark(comic.slug);
                                    },
                                    icon: Icon(
                                      bookmarkController.isBookmarked(comic.slug)
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: WHITE,
                                      size: SIZE_ICO,
                                    ),
                                  ),
                                ],
                              ),
    
                              HEIGHT_PAD,
    
                              // genre
                              Row(
                                children: [
                                  Text(
                                      "Thể loại: ",
                                      style: TextFormat.label
                                  ),
    
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: comic.categories.map(
                                                  (e) => Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius.all(Radius.circular(BORDER_RAD)),
                                                  ),
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    e.name,
                                                    style: TextStyle(
                                                        color: WHITE,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ).toList()
                                      ),
                                    ),
                                  )
                                ],
                              ),
    
                              HEIGHT_PAD,
    
                              Container(
                                key: _containerKey,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(30, 30, 30, 1),
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                ),
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      comic.content.replaceAll(RegExp(r'<[^>]*>'), ''),
                                      style: TextFormat.normal,
                                      maxLines: (controller.isExpand.value) ? 100 : 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    controller.isOverflowing.value
                                      ? (TextButton(
                                          onPressed: () {
                                            controller.seeMore();
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          child: Text(
                                            (controller.isExpand.value)
                                              ? "Thu gọn"
                                              : "Xem thêm",
                                            style: TextFormat.label,
                                          ),
                                        )
                                      )
                                      : SizedBox()
                                  ],
                                )
                              ),
    
                              HEIGHT_PAD,
    
                              Text(
                                  "Danh sách chương",
                                  style: TextFormat.title
                              ),
    
                              HEIGHT_PAD,

                              (chapters.isEmpty)
                                  ? Center(child: Text(
                                      'Chưa có chương nào được đăng tải!',
                                      style: TextFormat.normal,
                                    ))
                                  : Expanded(
                                  child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    var chapter = chapters[index];
                                    if (chapter.chapterName == chapterInHistory['chapter_name']) {
                                      controller.getHistory(chapter);
                                    }

                                    return ListTile(
                                      dense: true,
                                      leading: Text(
                                        'Chap ${chapter.chapterName}',
                                        style: TextFormat.title,
                                      ),
                                      trailing: (controller.chapterInHistory.value == chapter)
                                          ? Icon(Icons.star, color: Colors.red,)
                                          : null,
                                      onTap: () {
                                        Get.to(PageChapterComic(
                                          chapterItem: chapter, listChapter: chapters, slug: comic.slug,
                                        ));
                                      },
                                    );
                                  },
                                  itemCount: chapters.length,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  backgroundColor: Theme.of(context).colorScheme.shadow,
                );
              }
            );
          },
        );
      },
    );
  }
}