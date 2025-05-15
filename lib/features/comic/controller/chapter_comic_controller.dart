import 'package:comic_app/features/comic/models/chapter_item.dart';
import 'package:get/get.dart';

class ChapterComicController extends GetxController {
  RxBool isOpen = false.obs;
  f
  final Rx<ChapterItem> curChapter;
  final List<ChapterItem> listChapter;
  Rxn<ChapterItem> preChapter = Rxn<ChapterItem>();
  Rxn<ChapterItem> nexChapter = Rxn<ChapterItem>();

  ChapterComicController({required this.curChapter, required this.listChapter});

  void toggleListChapter() {
    isOpen.value = !isOpen.value;
  }

  void updateCurChapter(ChapterItem chapter) {
    curChapter.value = chapter;
    int index = listChapter.indexWhere((e) => e.chapterName == chapter.chapterName,);

    preChapter.value = (index < listChapter.length - 1) ? listChapter[index + 1] : null;
    nexChapter.value = (index > 0) ? listChapter[index - 1] : null;
  }
}