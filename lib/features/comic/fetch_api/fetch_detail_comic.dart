import 'dart:convert';
import 'package:comic_app/features/comic/models/detail_comic.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://otruyenapi.com/v1/api/truyen-tranh/";

Future<DetailComic> fetchDetailComic (String slug) async {
  final response = await http.get(Uri.parse(baseUrl + slug));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final detail = jsonData['data']['item'];

    return DetailComic.fromJson(detail);
  }
  else {
    throw Exception('Failed to load data');
  }
}