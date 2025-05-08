import 'package:comic_app/features/comic/fetch_api/fetch_search_comic.dart';
import 'package:comic_app/features/comic/models/comic_item.dart';
import 'package:get/get.dart';

class SearchComicController extends GetxController {
  var result = <ComicItem>[].obs;
  var hasResult = false.obs;

  void search({ String keyword = '' }) async {
    result.value = (await fetchSearchComic(keyword: keyword))!;
  }
}