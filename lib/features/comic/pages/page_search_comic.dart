import 'package:flutter/material.dart';

class PageSearchComic extends StatefulWidget {
  const PageSearchComic ({super.key});

  @override
  State<PageSearchComic> createState() => _PageSearchComicState();
}

class _PageSearchComicState extends State<PageSearchComic> {
  TextEditingController searchCtrl = TextEditingController();
  late int index = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 40.0,
            )
        ),
        title: Text("Search", style: TextStyle(
            color: Colors.white
          ),
        ),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).colorScheme.shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // search field
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.purple,
                  width: 3.0
                ),
                borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
              ),
              child: TextField(
                controller: searchCtrl,
                cursorColor: Colors.purple,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white,),
                  hintText: "Tìm truyên tranh..."
                ),
                onChanged: (value) {

                },
              ),
            ),

            SizedBox(height: 20.0,),

            // list comic
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {

                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            "https://otruyenapi.com/uploads/comics/da-sac-ma-phap-su-thien-tai-thumb.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // title
                              Text(
                                "Đa Sắc Ma Pháp Sư Thiên Tài",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              ),
                              // chapter
                              Text(
                                "Chapter 172",
                                style: TextStyle(color: Colors.white70, fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                  Divider(
                    thickness: 2.0,
                    color: Colors.white,
                  ),
                itemCount: index,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow
    );
  }
}
