import 'package:carousel_slider/carousel_slider.dart';
import 'package:comic_app/my_widget/rounded_image.dart';
import 'package:comic_app/my_widget/vertical_image_text.dart';
import 'package:flutter/material.dart';

class PageHomeComic extends StatelessWidget {
   PageHomeComic({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: VRoundedImage(imageUrl: 'https://sm.ign.com/ign_ap/cover/a/avatar-gen/avatar-generations_hugw.jpg',width: 40,isNetworkImage: true,),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello,", style: TextStyle(color: Colors.white),),
            Text("Tong Mai Truong Vu",style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, color: Colors.white))
        ],
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            Row(
              children: [
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index){
                      return VerticalImageText(image: 'https://th.bing.com/th/id/OIP.dik9TRSrNSq7nR93ZaWGvQHaHa?rs=1&pid=ImgDetMain', title: 'Category', onTap: () {});
                    },
                  ),
                )
              ],
            )
          ],
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