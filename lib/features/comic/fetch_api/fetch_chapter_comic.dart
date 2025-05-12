import 'dart:convert';
import 'package:comic_app/features/comic/models/chapter_comic.dart';
import 'package:http/http.dart' as http;

Future<ChapterComic> fetchChapterComic (String chapterApiComic) async {
  final response = await http.get(Uri.parse(chapterApiComic));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final chapter = jsonData['data']['item'];

    return ChapterComic.fromJson(chapter);
  }
  else {
    throw Exception('Failed to load data');
  }
}

