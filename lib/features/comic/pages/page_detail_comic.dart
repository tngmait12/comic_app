import 'package:comic_app/constants.dart';
import 'package:comic_app/features/comic/fetch_api/fetch_list_chapter.dart';
import 'package:comic_app/features/comic/models/comic_item.dart';
import 'package:comic_app/features/comic/pages/page_chapter_comic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageDetailComic extends StatelessWidget {
  PageDetailComic({super.key, required this.item});

  late int index = 10;
  final ComicItem item;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: fetchListChapter(slug: item.slug),
        builder: (context, snapshot) {
          var chapters = snapshot.data!;
          chapters.reversed.toList();

          return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: SIZE_ICO,
                  )
              ),
              backgroundColor: Theme.of(context).colorScheme.shadow
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network("https://otruyenapi.com/uploads/comics/${item.thumbUrl}",
                          fit: BoxFit.cover,
                          height: HEIGHT_IMG,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextFormat.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
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
                                          vertical: 10.0
                                      ),
                                      child: Text(
                                        "Đọc ngay",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {

                                    },
                                    icon: Icon(
                                      Icons.bookmark_border,
                                      color: WHITE,
                                      size: 45.0,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    ),
                  ],
                ),

                HEIGHT_PAD,

                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(30, 30, 30, 1),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [

                      // status
                      Row(
                        children: [
                          Text(
                              "Trạng thái: ",
                              style: TextFormat.normal
                          ),

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(Radius.circular(BORDER_RAD))
                            ),
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              item.status,
                              style: TextStyle(
                                  color: WHITE,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          )
                        ],
                      ),

                      HEIGHT_PAD,

                      // genre
                      Row(
                        children: [
                          Text(
                              "Thể loại: ",
                              style: TextFormat.normal
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: item.categories.map(
                                          (e) => Padding(
                                        padding: const EdgeInsets.all(5.0),
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
                    ],
                  ),
                ),

                HEIGHT_PAD,

                Text(
                    "Danh sách chương",
                    style: TextFormat.title
                ),

                HEIGHT_PAD,

                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var chapter = chapters.reversed.toList()[index];

                      return ListTile(
                        leading: Text(
                          "Chapter ${chapter.chapterName}",
                          style: TextFormat.title,
                        ),
                        onTap: () {
                          Get.to(PageChapterComic(chapterName: chapter.chapterName, chapterApiData: chapter.chapterApiData,));
                        },
                      );
                    },
                    itemCount: chapters.length,
                  ),
                )
              ],
            ),

          ),
          backgroundColor: Theme.of(context).colorScheme.shadow,
        );
        },
    );
  }
}
