import 'package:comic_app/features/comic/controller/search_comic_controller.dart';
import 'package:comic_app/features/comic/pages/page_detail_comic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class PageSearchComic extends StatelessWidget {
  PageSearchComic ({super.key});

  final TextEditingController TxtCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchComicController(), permanent: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.navigate_before_outlined,
              color: Colors.white,
              size: SIZE_ICO,
            )
        ),
        title: Text("Search", style: TextStyle(
            color: Colors.white
          ),
        ),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).colorScheme.shadow
      ),
      body: Obx(() =>
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // search field
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.purple,
                      width: 3.0
                  ),
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
                ),
                child: TextField(
                  controller: TxtCtrl,
                  cursorColor: Colors.purple,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.white,),
                      hintText: "Tìm truyện tranh..."
                  ),
                  autofocus: false,
                  onChanged: (value) {
                    controller.search(keyword: value);
                  },
                ),
              ),

              SizedBox(height: 20.0,),

              // list comic
              (controller.hasResult.value)
                ? Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    var comic = controller.result.value[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(PageDetailComic(slug: comic.slug,));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              "https://otruyenapi.com/uploads/comics/${comic.thumbUrl}",
                              fit: BoxFit.cover,
                              width: WIDTH_IMG,
                            ),
                          ),

                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // title
                                    Text(
                                      comic.name,
                                      style: TextFormat.title,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // chapter
                                    Text(
                                      "chap ${comic.latestChapter}",
                                      style: TextFormat.chapter,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    );
                  },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                          thickness: 2.0,
                          color: WHITE,
                        ),
                    itemCount: controller.result.value.length,
                )
              )
                : Center(
                  child: Text(
                  'Không có truyện được tìm thấy!',
                  style: TextFormat.normal,
                                ),
                )
            ],
          ),
        )
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow
    );
  }
}
