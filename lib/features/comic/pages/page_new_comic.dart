import 'package:comic_app/my_widget/grid_layout.dart';
import 'package:flutter/material.dart';

class PageNewComic extends StatelessWidget {
  const PageNewComic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Updated Comic", style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GridLayout(
                  itemCount: 8,
                  itemBuilder: (_ , index) => Container(
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
                  )
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
