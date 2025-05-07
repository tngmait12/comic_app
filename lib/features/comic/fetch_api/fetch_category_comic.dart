import 'dart:convert';

import 'package:comic_app/features/comic/models/comic_item.dart';
import 'package:http/http.dart' as http;

final baseUrl = "https://otruyenapi.com/v1/api/the-loai/";

Future<List<ComicItem>> fetchCategoryComic({int page = 1, String category = 'anime'}) async{
  final response = await http.get(Uri.parse("$baseUrl$category?page=$page"));

  if(response.statusCode == 200){
    final jsonData = json.decode(response.body);
    final comics = jsonData['data']['items'] as List;

    return comics.map(
      (e) => ComicItem.fromJson(e),
    ).toList();
  }else{
    throw Exception('Failed to load data');
  }
}