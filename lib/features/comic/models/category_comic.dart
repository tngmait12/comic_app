class CategoryComic{
  final String id;
  final String slug;
  final String name;

  const CategoryComic({
    required this.id,
    required this.slug,
    required this.name,
  });

  factory CategoryComic.fromJson(Map<String, dynamic> json) {
    return CategoryComic(
      id: json["_id"],
      slug: json["slug"],
      name: json["name"],
    );
  }
}