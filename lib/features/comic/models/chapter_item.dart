class ChapterItem {
  final String filename;
  final String chapterName;
  final String chapterTitle;
  final String chapterApiData;

  ChapterItem({
    required this.filename,
    required this.chapterName,
    required this.chapterTitle,
    required this.chapterApiData,
  });

  factory ChapterItem.fromJson(Map<String, dynamic> json) {
    return ChapterItem(
      filename: json['filename'],
      chapterName: json['chapter_name'],
      chapterTitle: json['chapter_title'],
      chapterApiData: json['chapter_api_data'],
    );
  }
}