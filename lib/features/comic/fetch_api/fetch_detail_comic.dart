import 'dart:convert';
import 'package:comic_app/features/comic/models/detail_comic.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://otruyenapi.com/v1/api/truyen-tranh/";

Future<DetailComic> fetchDetailComic({ required String slug }) async{
  final response = await http.get(Uri.parse(baseUrl + slug));

  if(response.statusCode == 200){
    final jsonData = json.decode(response.body);
    final comic = jsonData['data']['item'];

    return DetailComic.fromJson(comic);
  }else{
    throw Exception('Failed to load data');
  }
}