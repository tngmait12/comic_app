import 'package:carousel_slider/carousel_slider.dart';
import 'package:comic_app/features/comic/models/comic_item.dart';
import 'package:comic_app/features/comic/pages/page_category_comic.dart';
import 'package:comic_app/features/comic/pages/page_detail_comic.dart';
import 'package:comic_app/features/comic/pages/page_list_category.dart';
import 'package:comic_app/features/comic/pages/page_search_comic.dart';
import 'package:comic_app/my_widget/rounded_comic_item.dart';
import 'package:comic_app/my_widget/vertical_icon_text.dart';
import 'package:comic_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:comic_app/my_widget/grid_layout.dart';
import 'package:get/get.dart';
class PageHomeComic extends StatelessWidget {
   const PageHomeComic({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage('https://sm.ign.com/ign_ap/cover/a/avatar-gen/avatar-generations_hugw.jpg'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello,", style: TextStyle(color: Colors.white),),
            Text("Tong Mai Truong Vu",style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(PageSearchComic());
            },
            icon: Icon(Icons.search, color: Colors.white))
        ],
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.0,),

            ///Carousel Slider
            FutureBuilder<List<ComicItem>>(
                future: fetchComicHomeData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    print('Lỗi: ${snapshot.error}');
                    return Center(child: Text('Đã có lỗi xảy ra: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Không có ảnh'));
                  }

                  final carousels = snapshot.data!;

                  final comics = carousels.take(8).toList();

                  return CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                      ),
                      items: comics.map(
                        (comic) {
                          return GestureDetector(
                            onTap: () => Get.to(PageDetailComic(slug: comic.slug,)),
                            child: Container(
                              margin: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                    fit: StackFit.expand,
                                    children: [

                                      Image.network(
                                        "https://otruyenapi.com/uploads/comics/${comic.thumbUrl}",
                                        fit: BoxFit.cover,
                                        color: Colors.black.withOpacity(0.4),
                                        colorBlendMode: BlendMode.darken,
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Expanded(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              // Bên trái: Thông tin
                                              Flexible(

                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      comic.name,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      "Chapter ${comic.latestChapter}",
                                                      style: const TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              const SizedBox(width: 12), // Khoảng cách giữa text và ảnh

                                              // Bên phải: Ảnh rõ nét nhỏ hơn
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.network(
                                                  "https://otruyenapi.com/uploads/comics/${comic.thumbUrl}",
                                                  width: 100,
                                                  height: 140,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),

                  );
                },
            ),
            SizedBox(height: 16.0,),
            ///Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 85,
                    child: VerticalIconText(icon: Icon(Icons.category, color: Colors.white,), title: 'Thể loại',backgroundColor: Colors.green,onTap: () => Get.to(PageListCategory()),)
                ),
                SizedBox(
                    height: 85,
                    child: VerticalIconText(icon: Icon(Icons.spa, color: Colors.white,), title: 'Fantasy',backgroundColor: Colors.red,onTap: () => Get.to(PageCategoryComic(category: 'fantasy',)))
                ),SizedBox(
                    height: 85,
                    child: VerticalIconText(icon: Icon(Icons.create, color: Colors.white,), title: 'Manhwa',backgroundColor: Colors.blue,onTap: () => Get.to(PageCategoryComic(category: 'manhwa',)))
                ),SizedBox(
                    height: 85,
                    child: VerticalIconText(icon: Icon(Icons.book, color: Colors.white,), title: 'One shot',backgroundColor: Colors.yellow,onTap: () => Get.to(PageCategoryComic(category: 'one-shot',)))
                ),
              ],
            ),
            SizedBox(height: 16.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Truyện mới cập nhật", style: TextStyle(color: Colors.white, fontSize: 24),),
                IconButton(
                    onPressed: () {
                      final controller = Get.find<NavigationController>();
                      controller.selectedIndex.value = 1;
                    },
                    icon: Icon(Icons.arrow_forward_ios_outlined, size: 20,color: Colors.white,))
              ],
            ),

            FutureBuilder(
                future: fetchComicHomeData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Lỗi: ${snapshot.error}');
                    return Center(child: Text('Đã có lỗi xảy ra: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Không có ảnh'));
                  }

                  List<ComicItem> comics = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridLayout(
                        itemCount: comics.length,
                        itemBuilder: (context, index) {
                          final comic = comics[index];
                          return RoundedComicItem(onTap: () => Get.to(PageDetailComic(slug: comic.slug,)),name: comic.name,latestChapter: comic.latestChapter!,imageUrl: comic.thumbUrl,);
                        },
                    ),
                  );
                },
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
