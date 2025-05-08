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
    final searchController = Get.put(SearchComicController(), permanent: false);

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
                    searchController.search(keyword: value);
                  },
                ),
              ),

              SizedBox(height: 20.0,),

              // list comic
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    var comic = searchController.result.value[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(PageDetailComic(item: comic,));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                "https://otruyenapi.com/uploads/comics/${comic.thumbUrl}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // title
                                    Text(
                                      comic.name,
                                      style: TextFormat.title,
                                      maxLines: 2,
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
                    itemCount: searchController.result.value.length,
                )
              )
            ],
          ),
        )
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow
    );
  }
}
