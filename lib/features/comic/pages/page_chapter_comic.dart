import 'package:comic_app/constants.dart';
import 'package:comic_app/features/comic/controller/bookmark_controller.dart';
import 'package:comic_app/features/comic/controller/chapter_comic_controller.dart';
import 'package:comic_app/features/comic/models/chapter_comic.dart';
import 'package:comic_app/features/comic/models/chapter_item.dart';
import 'package:comic_app/my_widget/async_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../fetch_api/fetch_chapter_comic.dart';

class PageChapterComic extends StatelessWidget {
  PageChapterComic({super.key, required this.chapterItem, required this.listChapter, required this.slug});

  final ChapterItem chapterItem;
  final List<ChapterItem> listChapter;
  final String slug;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ChapterComicController controller = Get.put(ChapterComicController(curChapter: chapterItem.obs, listChapter: listChapter));
    final bookmarkController = Get.find<BookmarkController>();
    controller.updateCurChapter(chapterItem);

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
        title: Obx(() => Text(
          'Chap ${controller.curChapter.value.chapterName}',
          style: TextFormat.title,
        )),
        actions: [
          // list chapter
          IconButton(
              onPressed: () {
                controller.toggleListChapter();
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent)
              ),
              icon: Icon(Icons.list, color: WHITE, size: SIZE_ICO,)
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [

            Obx(() => SizedBox(
              height: MediaQuery.of(context).size.height - 80,
              child: FutureBuilder(
                future: fetchChapterComic(controller.curChapter.value.chapterApiData),
                builder: (context, snapshot) {
                  bookmarkController.addToHistory(slug, controller.curChapter.value.chapterName);

                  return AsyncWidget(
                    snapshot: snapshot,
                    builder: (context, snapshot) {
                      var chapterComic = snapshot.data! as ChapterComic;
                      return ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          var chapterImage = chapterComic.chapterImage[index];
                          return Image.network(
                            "https://sv1.otruyencdn.com/${chapterComic.chapterPath}/${chapterImage.imageFile}",
                            fit: BoxFit.cover,
                          );
                        },
                        itemCount: chapterComic.chapterImage.length,
                      );
                    },
                  );
                },
              ),
            )),

            // navigation
            Obx(() => Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      // previous
                      IconButton(
                        onPressed: () {
                          if (controller.preChapter.value == null) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("đây là chương đầu tiên"),
                                  duration: Duration(seconds: 2),
                                )
                            );
                          }
                          else {

                            controller.updateCurChapter(controller.preChapter.value!, );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
                        ),
                        icon: Icon(Icons.keyboard_arrow_left, color: WHITE, size: SIZE_ICO,),
                      ),

                      // book mark
                      IconButton(
                        onPressed: () {
                          bookmarkController.toggleBookmark(slug);
                        },
                        icon: Icon(
                          bookmarkController.isBookmarked(slug)
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: WHITE,
                          size: SIZE_ICO,
                        ),
                      ),

                      // top page
                      IconButton(
                          onPressed: () {
                            _scrollController.animateTo(0, duration: Duration(microseconds: 500), curve: Curves.easeOut);
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent)
                          ),
                          icon: Icon(Icons.keyboard_arrow_up, color: WHITE, size: SIZE_ICO,)
                      ),

                      //next
                      IconButton(
                          onPressed: () {
                            if (controller.nexChapter.value == null) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("đây là chương mới nhất"),
                                    duration: Duration(seconds: 2),
                                  )
                              );
                            }
                            else {
                              controller.updateCurChapter(controller.nexChapter.value!);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent)
                          ),
                          icon: Icon(Icons.keyboard_arrow_right, color: WHITE, size: SIZE_ICO,)
                      ),
                    ],
                  ),
                )
            )),

            // list chapter
            Obx(() => Positioned(
              right: 0,
              top: 0,
              child: AnimatedContainer(
                  decoration: BoxDecoration(
                      color: Colors.black87
                  ),
                  width: (controller.isOpen.value) ? 200 : 0,
                  height: MediaQuery.of(context).size.height - 160,
                  duration: Duration(milliseconds: 300),
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        var chapter = listChapter[index];

                        return ListTile(
                          onTap: () {
                            controller.updateCurChapter(chapter);
                          },
                          leading: Text('Chap ${chapter.chapterName}', style: TextFormat.title,),
                          trailing: (controller.curChapter.value.chapterName == chapter.chapterName)
                              ? Icon(Icons.star, color: Colors.red,)
                              : null,
                        );
                      },
                      itemCount: listChapter.length
                  )
              ),
            )),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
