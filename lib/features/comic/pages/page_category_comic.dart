import 'package:comic_app/my_widget/grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageCategoryComic extends StatelessWidget {
  const PageCategoryComic({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> categories = ["Truyen moi", "Truyen hay", "Dang phat hanh","Top Thang","Top Luot xem"];
    String selectedCategory = "Truyen moi";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.back(); // hoặc Navigator.pop(context)
          },
        ),
        title: Text("Danh muc", style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.shadow,
        actions: [
          DropdownButton<String>(
            value: selectedCategory,
            dropdownColor: Colors.black, // Nền của menu dropdown
            style: TextStyle(color: Colors.white), // Màu chữ của item đã chọn
            iconEnabledColor: Colors.white, // Màu icon mũi tên
            underline: SizedBox(), // Xóa gạch dưới nếu muốn
            items: categories.map(
                  (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: TextStyle(color: Colors.white), // Màu chữ trong menu dropdown
                ),
              ),
            ).toList(),
            onChanged: (value) {
              // setState(() {
              //   selectedCategory = value!;
              // });
              selectedCategory = value!;
            },
          ),
        ],
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
