import 'dart:convert';

import 'package:comic_app/features/comic/models/comic_item.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StatusComicController extends GetxController {
  final comics = <ComicItem>[].obs;
  final isLoading = false.obs;
  final hasMore = true.obs;
  final currentPage = 1.obs;
  final selectedSlug = 'truyen-moi'.obs;

  void setCategory(String slug) {
    selectedSlug.value = slug;
    fetchComics(forceRefresh: true);
  }

  Future<void> fetchComics({bool forceRefresh = false}) async {
    if (isLoading.value || (!hasMore.value && !forceRefresh)) return;

    if (forceRefresh) {
      comics.clear();
      currentPage.value = 1;
      hasMore.value = true;
    }

    isLoading.value = true;
    final url = "https://otruyenapi.com/v1/api/danh-sach/${selectedSlug.value}?page=${currentPage.value}";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final items = jsonData['data']['items'] as List;
      final newComics = items.map((e) => ComicItem.fromJson(e)).toList();

      comics.addAll(newComics);
      if (newComics.length < 24) hasMore.value = false;
      currentPage.value++;
    }

    isLoading.value = false;
  }

  @override
  void onInit() {
    fetchComics();
    super.onInit();
  }
}
