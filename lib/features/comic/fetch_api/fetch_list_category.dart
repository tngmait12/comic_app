import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:comic_app/features/comic/models/category_comic.dart';

final baseUrl = "https://otruyenapi.com/v1/api/the-loai";

Future<List<CategoryComic>> fetchListCategoryComic() async{
  final response = await http.get(Uri.parse(baseUrl));

  if(response.statusCode == 200){
    final jsonData = json.decode(response.body);
    final categories = jsonData['data']['item'] as List;

    return categories.map(
      (e) => CategoryComic.fromJson(e)
    ).toList();
  } else{
    throw Exception('Failed to load data');
  }
}