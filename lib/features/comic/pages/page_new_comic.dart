import 'package:comic_app/features/comic/controller/category_comic_controller.dart';
import 'package:comic_app/features/comic/controller/status_comic_controller.dart';
import 'package:comic_app/my_widget/grid_layout.dart';
import 'package:comic_app/my_widget/rounded_comic_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNewComic extends StatelessWidget {
  const PageNewComic({super.key});

  @override
  Widget build(BuildContext context) {

    Map<String, String> categoryMap = {
      'Truyện mới': 'truyen-moi',
      'Sap ra mat': 'sap-ra-mat',
      'Đang phát hành': 'dang-phat-hanh',
      'Hoan Thanh': 'hoan-thanh',
    };


    final comicController = Get.put(StatusComicController());
    
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        comicController.fetchComics();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("New Updated Comic", style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.shadow,
        actions: [
          Obx(
          () => DropdownButton<String>(
              value: categoryMap.entries
                  .firstWhere((entry) => entry.value == comicController.selectedSlug.value)
                  .key,
              dropdownColor: Colors.black, // Nền của menu dropdown
              style: TextStyle(color: Colors.white), // Màu chữ của item đã chọn
              iconEnabledColor: Colors.white, // Màu icon mũi tên
              underline: SizedBox(), // Xóa gạch dưới nếu muốn
              items: categoryMap.keys.map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(color: Colors.white), // Màu chữ trong menu dropdown
                  ),
                ),
              ).toList(),
              onChanged: (value) {
                if(value != null){
                  comicController.setCategory(categoryMap[value]!);
                }
              },
            ),
          ),
        ],
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
                  controller: scrollController,
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
