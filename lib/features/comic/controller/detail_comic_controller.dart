import 'package:comic_app/features/comic/models/chapter_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailComicController extends GetxController {
  RxBool isExpand = false.obs;
  RxDouble containerWidth = 0.0.obs;
  RxBool isOverflowing = true.obs;
  final Rxn<ChapterItem> chapterInHistory = Rxn<ChapterItem>();

  void seeMore() {
    if (isExpand.value) {
      isExpand.value = false;
    }
    else {
      isExpand.value = true;
    }
  }

  void getContainerWidth(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        containerWidth.value = renderBox.size.width;
      }
    });
  }

  void checkTextOverflow({
    required String text,
    required TextStyle style,
    required int maxLines,
  }) {
    if (containerWidth.value == 0) return;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: containerWidth.value);

    isOverflowing.value = textPainter.didExceedMaxLines;
  }

  void getHistory(ChapterItem chapterItem) {
    chapterInHistory.value = chapterItem;
  }
}