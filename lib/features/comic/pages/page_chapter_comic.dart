import 'package:comic_app/constants.dart';
import 'package:comic_app/features/comic/fetch_api/fetch_chapter_comic.dart';
import 'package:comic_app/features/comic/models/chapter_comic.dart';
import 'package:comic_app/my_widget/async_widget.dart';
import 'package:flutter/material.dart';

class PageChapterComic extends StatelessWidget {
  PageChapterComic({super.key, required this.chapterName, required this.chapterApiData});

  final String chapterName;
  final String chapterApiData;

  double navBarHeight = 100;
  final ScrollController _scrollController = ScrollController();
  int index = 20;
  late bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: SIZE_ICO,
            )
        ),
        title: Text(
          "Chapter $chapterName",
          style: TextFormat.title,
        ),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: FutureBuilder(
          future: fetchChapterComic(chapterApiData),
          builder: (context, snapshot) {
            return AsyncWidget(
                snapshot: snapshot,
                builder: (context, snapshot) {
                  var chapterComic = snapshot.data! as ChapterComic;
                  return GestureDetector(
                    onTap: () {
                    },
                    child: Stack(
                      children: [

                        SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              var chapterImage = chapterComic.chapterImage[index];
                              return Image.network(
                                "https://sv1.otruyencdn.com/${chapterComic.chapterPath}/${chapterImage.imageFile}",
                                fit: BoxFit.cover,
                              );
                            },
                            itemCount: chapterComic.chapterImage.length,
                          ),
                        ),

                        // navigation
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // previous
                                  ElevatedButton(
                                    onPressed: () {

                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
                                    ),
                                    child: Icon(Icons.keyboard_arrow_left, color: WHITE, size: SIZE_ICO,),
                                  ),

                                  // book mark
                                  ElevatedButton(
                                    onPressed: () {

                                    },
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent)
                                    ),
                                    child: Icon(Icons.bookmark_border, color: WHITE, size: SIZE_ICO,),
                                  ),

                                  // list chapter
                                  ElevatedButton(
                                      onPressed: () {
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent)
                                      ),
                                      child: Icon(Icons.list, color: WHITE, size: SIZE_ICO,)
                                  ),

                                  ElevatedButton(
                                      onPressed: () {
                                        _scrollController.animateTo(0, duration: Duration(microseconds: 500), curve: Curves.easeOut);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent)
                                      ),
                                      child: Icon(Icons.keyboard_arrow_up, color: WHITE, size: SIZE_ICO,)
                                  ),

                                  //next
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {

                                        },
                                        style: ButtonStyle(
                                            backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent)
                                        ),
                                        child: Icon(Icons.keyboard_arrow_right, color: WHITE, size: SIZE_ICO,)
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),

                        // list chapter
                        Positioned(
                          right: 0,
                          top: 0,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: _isOpen ? 200.0 : 0,
                            height: MediaQuery.of(context).size.height - 200.0,
                            decoration: BoxDecoration(
                                color: Colors.black87
                            ),
                            curve: Curves.easeOut,
                            child: _isOpen ? ListView.builder(
                                itemBuilder: (context, index) => ListTile(
                                  onTap: () {
                                  },
                                  leading: Text("Chapter $index", style: TextFormat.normal,),
                                ),
                                itemCount: index
                            ) : null,
                          ),
                        )
                      ],
                    ),
                  );
                },
            );
          },
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );  }
}
