import 'package:carousel_slider/carousel_slider.dart';
import 'package:comic_app/features/comic/pages/page_search_comic.dart';
import 'package:comic_app/my_widget/rounded_image.dart';
import 'package:comic_app/my_widget/vertical_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:comic_app/my_widget/grid_layout.dart';
class PageHomeComic extends StatelessWidget {
   const PageHomeComic({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RoundedImage(imageUrl: 'https://sm.ign.com/ign_ap/cover/a/avatar-gen/avatar-generations_hugw.jpg',width: 40,isNetworkImage: true,),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 16.0,),
              CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(
                    height: 200, // Set the height of the carousel
                    autoPlay: false, // Enable auto-play
                    // autoPlayCurve: Curves.easeInOut, // Set the auto-play curve
                    // autoPlayAnimationDuration: Duration(milliseconds: 500), // Set the auto-play animation duration
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  )
              ),
              SizedBox(height: 16.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 80,
                    child: VerticalIconText(icon: Icon(Icons.boy, color: Colors.white,), title: 'Danh Muc',backgroundColor: Colors.green,)
                  ),
                  SizedBox(
                      height: 80,
                      child: VerticalIconText(icon: Icon(Icons.boy, color: Colors.white,), title: 'Danh Muc',backgroundColor: Colors.red,)
                  ),SizedBox(
                      height: 80,
                      child: VerticalIconText(icon: Icon(Icons.boy, color: Colors.white,), title: 'Danh Muc',backgroundColor: Colors.blue,)
                  ),SizedBox(
                      height: 80,
                      child: VerticalIconText(icon: Icon(Icons.boy, color: Colors.white,), title: 'Danh Muc',backgroundColor: Colors.yellow,)
                  ),
                ],
              ),
              SizedBox(height: 16.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Manga New Updated", style: TextStyle(color: Colors.white, fontSize: 24),),
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right, size: 24,color: Colors.white,))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridLayout(itemCount: 8, itemBuilder: (_ , index) => Container(
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        // Background image
                        Image.network(
                          "https://otruyenapi.com/uploads/comics/da-sac-ma-phap-su-thien-tai-thumb.jpg",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        // Bottom overlay with title + chapter
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black87],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Đa Sắc Ma Pháp Sư Thiên Tài",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Chapter 172",
                                  style: TextStyle(color: Colors.white70, fontSize: 11),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
List<String> carouselItems = [
  'https://otruyenapi.com/uploads/comics/dung-gia-x-nu-ma-vuong-thumb.jpg',
  'https://otruyenapi.com/uploads/comics/dung-gia-x-nu-ma-vuong-thumb.jpg',
  'https://otruyenapi.com/uploads/comics/dung-gia-x-nu-ma-vuong-thumb.jpg',
];

final List<Widget> imageSliders = carouselItems
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. ${carouselItems.indexOf(item)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();