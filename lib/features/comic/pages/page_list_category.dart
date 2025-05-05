import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageListCategory extends StatelessWidget {
  const PageListCategory({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> categories = ["Truyen moi", "Truyen hay", "Dang phat hanh","Top Thang","Top Luot xem"];

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
      body: ListView.builder(
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
                  category,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            );

          },
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
