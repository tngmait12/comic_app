import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:comic_app/features/comic/models/comic_item.dart';

class CategoryComicController extends GetxController {
  final comics = <ComicItem>[].obs;
  final isLoading = false.obs;
  final hasMore = true.obs;
  int currentPage = 1;
  final String category;

  CategoryComicController(this.category);

  @override
  void onInit() {
    fetchComics();
    super.onInit();
  }

  Future<void> fetchComics() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    final response = await http.get(Uri.parse(
      "https://otruyenapi.com/v1/api/the-loai/$category?page=$currentPage",
    ));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final items = jsonData['data']['items'] as List;
      final newComics = items.map((e) => ComicItem.fromJson(e)).toList();

      comics.addAll(newComics);
      if (newComics.length < 24) hasMore.value = false;
      currentPage++;
    }
    isLoading.value = false;
  }
}
