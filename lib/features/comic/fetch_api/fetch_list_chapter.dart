import 'dart:convert';
import 'package:comic_app/features/comic/models/chapter_item.dart';
import 'package:comic_app/features/comic/models/detail_comic.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://otruyenapi.com/v1/api/truyen-tranh/";

Future<List<ChapterItem>> fetchListChapter({ required String slug }) async{
  final response = await http.get(Uri.parse(baseUrl + slug));

  if(response.statusCode == 200){
    final jsonData = json.decode(response.body);
    final server = jsonData['data']['item']['chapters'] as List;

    if (server.isEmpty) return <ChapterItem>[];

    final comics = server[0]['server_data'] as List;

    return comics.map(
          (e) => ChapterItem.fromJson(e),
    ).toList();
  }else{
    throw Exception('Failed to load data');
  }
}