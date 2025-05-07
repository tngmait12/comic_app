import 'package:comic_app/features/comic/controller/category_comic_controller.dart';
import 'package:comic_app/my_widget/grid_layout.dart';
import 'package:comic_app/my_widget/rounded_comic_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageCategoryComic extends StatelessWidget {

  final String category;
  final controller = ScrollController();

  PageCategoryComic({super.key, required this.category});

  @override
  Widget build(BuildContext context) {

    final comicController = Get.put(CategoryComicController(category));

    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent - 200) {
        comicController.fetchComics();
      }
    });


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.back(); // hoặc Navigator.pop(context)
          },
        ),
        title: Text(category, style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: Obx(
          () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      mainAxisExtent: 288,
                    ),
                    controller: controller,
                    itemCount: comicController.comics.length,
                    itemBuilder: (context, index) {
                      final comic = comicController.comics[index];
                      return RoundedComicItem(imageUrl: comic.thumbUrl, name: comic.name, latestChapter: comic.latestChapter!);
                    },
                ),
              ),
              if (comicController.isLoading.value)
                Center(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (!comicController.hasMore.value)
                Center(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Đã tải hết dữ liệu', style: TextStyle(color: Colors.white)),
                  ),
                ),
            ],
          ),
        ),

      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
