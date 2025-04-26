
import 'chapter_item.dart';

class ComicItem {
  final String id;
  final String name;
  final String slug;
  final List<String> originName;
  final String status;
  final String thumbUrl;
  final String updatedAt;
  final List<CategoryItem> categories;
  final List<ChapterItem> chaptersLatest;

  ComicItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.status,
    required this.thumbUrl,
    required this.updatedAt,
    required this.categories,
    required this.chaptersLatest,
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
      chaptersLatest: (json['chaptersLatest'] as List)
          .map((item) => ChapterItem.fromJson(item))
          .toList(),
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