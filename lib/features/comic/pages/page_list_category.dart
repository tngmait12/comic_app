import 'package:comic_app/features/comic/fetch_api/fetch_list_category.dart';
import 'package:comic_app/features/comic/models/category_comic.dart';
import 'package:comic_app/my_widget/async_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageListCategory extends StatelessWidget {
  const PageListCategory({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Danh sach the loai", style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: FutureBuilder(
          future: fetchListCategoryComic(),
          builder: (context, snapshot) {
            return AsyncWidget(
                snapshot: snapshot,
                builder: (context, snapshot) {
                  var categories = snapshot.data! as List<CategoryComic>;
                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[850], // nền nổi bật hơn shadow
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            category.name,
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );

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
