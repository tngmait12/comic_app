import 'package:flutter/material.dart';

class PageFavoriteComic extends StatelessWidget {
  const PageFavoriteComic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Comic"),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
