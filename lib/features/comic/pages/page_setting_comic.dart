import 'package:flutter/material.dart';

class PageSettingComic extends StatelessWidget {
  const PageSettingComic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting User", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }
}
