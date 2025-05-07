import 'package:flutter/material.dart';

class RoundedComicItem extends StatelessWidget {
  const RoundedComicItem({
    super.key, required this.imageUrl, required this.name, required this.latestChapter, this.onTap,
  });

  final String imageUrl, name, latestChapter;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Background image
              Image.network(
                "https://otruyenapi.com/uploads/comics/$imageUrl",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              // Bottom overlay with title + chapter
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: Colors.black.withOpacity(0.6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Chapter $latestChapter",
                        style: TextStyle(color: Colors.white70, fontSize: 11,fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}