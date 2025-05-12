
import 'package:comic_app/features/comic/models/chapter_item.dart';
import 'package:comic_app/features/comic/models/comic_item.dart';


class DetailComic {

  final String id;
  final String name;
  final String slug;
  final String content;
  final String status;
  final String thumbUrl;
  final List<CategoryItem> categories;
  final List<ChapterItem> chapters;
  final String updatedAt;

  const DetailComic({
    required this.id,
    required this.name,
    required this.slug,
    required this.content,
    required this.status,
    required this.thumbUrl,
    required this.categories,
    required this.chapters,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'slug': this.slug,
      'content': this.content,
      'status': this.status,
      'thumbUrl': this.thumbUrl,
      'category': this.categories,
      'chapters': this.chapters,
      'updateAt': this.updatedAt,
    };
  }

  factory DetailComic.fromJson(Map<String, dynamic> json) {
    var serverChapter = json['chapters'];

    return DetailComic(
      categories: (json['category'] as List).map((i) => CategoryItem.fromJson(i)).toList(),
      chapters: (serverChapter.isEmpty)
          ? <ChapterItem>[]
          : (serverChapter[0]['server_data'] as List).map((i) => ChapterItem.fromJson(i)).toList(),
      content: json['content'],
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      status: json['status'],
      thumbUrl: json['thumb_url'],
      updatedAt: json['updatedAt'],
    );
  }
}