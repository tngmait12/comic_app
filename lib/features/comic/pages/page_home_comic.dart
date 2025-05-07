import 'package:carousel_slider/carousel_slider.dart';
import 'package:comic_app/features/comic/models/comic_item.dart';
import 'package:comic_app/features/comic/pages/page_category_comic.dart';
import 'package:comic_app/features/comic/pages/page_detail_comic.dart';
import 'package:comic_app/features/comic/pages/page_list_category.dart';
import 'package:comic_app/features/comic/pages/page_new_comic.dart';
import 'package:comic_app/features/comic/pages/page_search_comic.dart';
import 'package:comic_app/my_widget/rounded_comic_item.dart';
import 'package:comic_app/my_widget/vertical_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:comic_app/my_widget/grid_layout.dart';
import 'package:get/get.dart';
import 'package:comic_app/features/comic/controller/home_comic_controller.dart';

class PageHomeComic extends StatelessWidget {
   const PageHomeComic({super.key});


  @override
  Widget build(BuildContext context) {

    final comicController = Get.put(HomeComicController());

    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        comicController.fetchComics();
      }
    });

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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PageSearchComic(),
                )
              );
            },
            icon: Icon(Icons.search, color: Colors.white))
        ],
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      return Container(
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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

                            ],
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
                    height: 80,
                    width: ((MediaQuery.of(context).size.width) - 64) / 4,
                    child: VerticalIconText(icon: Icon(Icons.category, color: Colors.white,), title: 'The loai',backgroundColor: Colors.green,onTap: () => Get.to(PageListCategory()),)
                ),
                SizedBox(
                    height: 80,
                    width: ((MediaQuery.of(context).size.width) - 64) / 4,
                    child: VerticalIconText(icon: Icon(Icons.spa, color: Colors.white,), title: 'Fantasy',backgroundColor: Colors.red,onTap: () => Get.to(PageCategoryComic(category: 'fantasy',)))
                ),SizedBox(
                    height: 80,
                    width: ((MediaQuery.of(context).size.width) - 64) / 4,
                    child: VerticalIconText(icon: Icon(Icons.create, color: Colors.white,), title: 'Manhwa',backgroundColor: Colors.blue,onTap: () => Get.to(PageCategoryComic(category: 'manhwa',)))
                ),SizedBox(
                    height: 80,
                    width: ((MediaQuery.of(context).size.width) - 64) / 4,
                    child: VerticalIconText(icon: Icon(Icons.book, color: Colors.white,), title: 'One shot',backgroundColor: Colors.yellow,onTap: () => Get.to(PageCategoryComic(category: 'one-shot',)))
                ),
              ],
            ),
            SizedBox(height: 16.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Manga New Updated", style: TextStyle(color: Colors.white, fontSize: 24),),
                IconButton(onPressed: () => Get.to(PageNewComic()), icon: Icon(Icons.arrow_forward_ios_outlined, size: 24,color: Colors.white,))
              ],
            ),

            Expanded(
              child: Obx(
                    () => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        mainAxisExtent: 288,
                      ),
                      controller: scrollController,
                      itemCount: comicController.comics.length,
                      itemBuilder: (context, index) {
                        if (index < comicController.comics.length){
                          final comic = comicController.comics[index];
                          return RoundedComicItem(imageUrl: comic.thumbUrl, name: comic.name, latestChapter: comic.latestChapter!, onTap: () => Get.to(PageDetailComic(slug: comic.slug)),);
                        }else{
                          if (comicController.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (!comicController.hasMore.value) {
                            return const Center(child: Text('Đã tải hết dữ liệu', style: TextStyle(color: Colors.white)));
                          } else {
                            return const SizedBox.shrink();
                          }
                        }

                      },
                    )
              ),
            ),
          ],
        ),
      ),
      // body: CustomScrollView(
      //   controller: scrollController,
      //   slivers: [
      //     SliverToBoxAdapter(
      //       child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //         child: Column(
      //           children: [
      //             SizedBox(height: 16.0,),
      //
      //             ///Carousel Slider
      //             FutureBuilder<List<ComicItem>>(
      //               future: fetchComicHomeData(),
      //               builder: (context, snapshot) {
      //                 if (snapshot.connectionState == ConnectionState.waiting) {
      //                   return const Center(child: CircularProgressIndicator());
      //                 } else if (snapshot.hasError) {
      //                   print('Lỗi: ${snapshot.error}');
      //                   return Center(child: Text('Đã có lỗi xảy ra: ${snapshot.error}'));
      //                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //                   return Center(child: Text('Không có ảnh'));
      //                 }
      //
      //                 final carousels = snapshot.data!;
      //
      //                 final comics = carousels.take(8).toList();
      //
      //                 return CarouselSlider(
      //                   options: CarouselOptions(
      //                     height: 200,
      //                     autoPlay: true,
      //                     enlargeCenterPage: true,
      //                     aspectRatio: 2.0,
      //                   ),
      //                   items: comics.map(
      //                         (comic) {
      //                       return Container(
      //                         margin: const EdgeInsets.all(5.0),
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(12),
      //                           child: Stack(
      //                             fit: StackFit.expand,
      //                             children: [
      //
      //                               Image.network(
      //                                 "https://otruyenapi.com/uploads/comics/${comic.thumbUrl}",
      //                                 fit: BoxFit.cover,
      //                                 color: Colors.black.withOpacity(0.4),
      //                                 colorBlendMode: BlendMode.darken,
      //                               ),
      //
      //                               Padding(
      //                                 padding: const EdgeInsets.all(12.0),
      //                                 child: Row(
      //                                   crossAxisAlignment: CrossAxisAlignment.center,
      //                                   children: [
      //                                     // Bên trái: Thông tin
      //                                     Flexible(
      //                                       child: Column(
      //                                         crossAxisAlignment: CrossAxisAlignment.start,
      //                                         mainAxisAlignment: MainAxisAlignment.center,
      //                                         children: [
      //                                           Text(
      //                                             comic.name,
      //                                             style: const TextStyle(
      //                                               color: Colors.white,
      //                                               fontSize: 18,
      //                                               fontWeight: FontWeight.bold,
      //                                             ),
      //                                             maxLines: 2,
      //                                             overflow: TextOverflow.ellipsis,
      //                                           ),
      //                                           const SizedBox(height: 8),
      //                                           Text(
      //                                             "Chapter ${comic.latestChapter}",
      //                                             style: const TextStyle(
      //                                               color: Colors.white70,
      //                                               fontSize: 14,
      //                                             ),
      //                                           ),
      //                                         ],
      //                                       ),
      //                                     ),
      //
      //                                     const SizedBox(width: 12), // Khoảng cách giữa text và ảnh
      //
      //                                     // Bên phải: Ảnh rõ nét nhỏ hơn
      //                                     ClipRRect(
      //                                       borderRadius: BorderRadius.circular(8),
      //                                       child: Image.network(
      //                                         "https://otruyenapi.com/uploads/comics/${comic.thumbUrl}",
      //                                         width: 100,
      //                                         height: 140,
      //                                         fit: BoxFit.cover,
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //
      //                             ],
      //                           ),
      //                         ),
      //                       );
      //                     },
      //                   ).toList(),
      //
      //                 );
      //               },
      //             ),
      //             SizedBox(height: 16.0,),
      //             ///Category
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //               children: [
      //                 SizedBox(
      //                     height: 80,
      //                     child: VerticalIconText(icon: Icon(Icons.category, color: Colors.white,), title: 'Danh Muc',backgroundColor: Colors.green,onTap: () => Get.to(PageListCategory()),)
      //                 ),
      //                 SizedBox(
      //                     height: 80,
      //                     child: VerticalIconText(icon: Icon(Icons.female, color: Colors.white,), title: 'A girl',backgroundColor: Colors.red,onTap: () => Get.to(PageCategoryComic(category: 'adult',)))
      //                 ),SizedBox(
      //                     height: 80,
      //                     child: VerticalIconText(icon: Icon(Icons.male, color: Colors.white,), title: 'A boy',backgroundColor: Colors.blue,onTap: () => Get.to(PageCategoryComic(category: 'anime',)))
      //                 ),SizedBox(
      //                     height: 80,
      //                     child: VerticalIconText(icon: Icon(Icons.boy, color: Colors.white,), title: 'Danh Muc',backgroundColor: Colors.yellow,onTap: () => Get.to(PageCategoryComic(category: 'chuyen-sinh',)))
      //                 ),
      //               ],
      //             ),
      //             SizedBox(height: 16.0,),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Text("Manga New Updated", style: TextStyle(color: Colors.white, fontSize: 24),),
      //                 IconButton(onPressed: () => Get.to(PageNewComic()), icon: Icon(Icons.arrow_forward_ios_outlined, size: 24,color: Colors.white,))
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Obx(
      //           () => SliverPadding(
      //         padding: const EdgeInsets.all(8.0),
      //         sliver: SliverGrid(
      //             delegate: SliverChildBuilderDelegate(
      //                   (context, index) {
      //                 final comic = comicController.comics[index];
      //                 return RoundedComicItem(imageUrl: comic.thumbUrl, name: comic.name, latestChapter: comic.latestChapter!, onTap: () => Get.to(PageDetailComic(slug: comic.slug)),);
      //               },
      //               childCount: comicController.comics.length,
      //             ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 2,
      //           mainAxisSpacing: 16.0,
      //           crossAxisSpacing: 16.0,
      //           mainAxisExtent: 288,
      //         )
      //         ),
      //       ),
      //     ),
      //     Obx(() {
      //       if (comicController.isLoading.value) {
      //         return SliverToBoxAdapter(
      //           child: Center(child: CircularProgressIndicator()),
      //         );
      //       } else if (!comicController.hasMore.value) {
      //         return SliverToBoxAdapter(
      //           child: Center(child: Text("Đã tải hết dữ liệu", style: TextStyle(color: Colors.white))),
      //         );
      //       } else {
      //         return SliverToBoxAdapter(child: SizedBox.shrink());
      //       }
      //     }),
      //   ],
      // ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
