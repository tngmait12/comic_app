class ChapterComic {
    List<ChapterImage> chapterImage;
    String chapterName;
    String chapterPath;
    String comicName;
    String id;

    ChapterComic({required this.chapterImage, required this.chapterName, required this.chapterPath, required this.comicName, required this.id});

    factory ChapterComic.fromJson(Map<String, dynamic> json) {
        return ChapterComic(
            chapterImage: (json['chapter_image'] as List).map((i) => ChapterImage.fromJson(i)).toList(),
            chapterName: json['chapter_name'],
            chapterPath: json['chapter_path'],
            comicName: json['comic_name'],
            id: json['_id'],
        );
     }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['chapter_image'] = chapterImage.map((v) => v.toJson()).toList();
        data['chapter_name'] = chapterName;
        data['chapter_path'] = chapterPath;
        data['comic_name'] = comicName;
        data['_id'] = id;
        return data;
     }
}

class ChapterImage {
    String imageFile;
    int imagePage;

    ChapterImage({required this.imageFile, required this.imagePage});

    factory ChapterImage.fromJson(Map<String, dynamic> json) {
        return ChapterImage(
            imageFile: json['image_file'],
            imagePage: json['image_page'],
        );
     }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['image_file'] = imageFile;
        data['image_page'] = imagePage;
        return data;
     }
}