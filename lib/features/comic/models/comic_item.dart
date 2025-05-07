import 'dart:convert';

import 'package:http/http.dart' as http;

class ComicItem {
  final String id;
  final String name;
  final String slug;
  final List<String> originName;
  final String status;
  final String thumbUrl;
  final String updatedAt;
  final List<CategoryItem> categories;
  final String? latestChapter;

  ComicItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.status,
    required this.thumbUrl,
    required this.updatedAt,
    required this.categories,
    this.latestChapter,
  });

  factory ComicItem.fromJson(Map<String, dynamic> json) {
    return ComicItem(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      originName: List<String>.from(json['origin_name'] ?? []),
      status: json['status'],
      thumbUrl: json['thumb_url'],
      updatedAt: json['updatedAt'],
      categories: (json['category'] as List)
          .map((item) => CategoryItem.fromJson(item))
          .toList(),
      latestChapter: (json['chaptersLatest'] != null && json['chaptersLatest'].isNotEmpty)
          ? json['chaptersLatest'][0]['chapter_name']
          : "next will be updated soon",
    );
  }
}

class CategoryItem {
  final String id;
  final String name;
  final String slug;

  CategoryItem({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

Future<List<ComicItem>> fetchComicHomeData() async {
  final response = await http.get(Uri.parse('https://otruyenapi.com/v1/api/home'));
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final items = jsonData['data']['items'] as List;
    return items.map((item) => ComicItem.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}