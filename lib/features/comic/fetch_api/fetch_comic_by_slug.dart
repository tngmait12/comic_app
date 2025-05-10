
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comic_item.dart';

Future<ComicItem> fetchComicBySlug(String slug) async {
  final response = await http.get(Uri.parse("https://otruyenapi.com/v1/api/truyen-tranh/$slug"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return ComicItem.fromJson(data['data']['item']);
  } else {
    throw Exception('Lỗi khi lấy comic');
  }
}
