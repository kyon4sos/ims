import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ims/api/api.dart';
import 'package:ims/components/card.dart';
import 'package:ims/components/custom_indicator.dart';
import 'package:ims/model/Blog.dart';
import 'package:ims/model/catalog.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  List<String> tabs = ["推荐", "广场"];
  late List<CatalogModel> catalogs = [
    new CatalogModel(title: "热门话题", icon: "1", subTitle: "时事热议"),
    new CatalogModel(title: "网易诗词", icon: "2", subTitle: "以诗会友"),
    new CatalogModel(title: "轻松一刻", icon: "3", subTitle: "推荐关注"),
    new CatalogModel(title: "家里那些事", icon: "4", subTitle: "编辑推荐"),
    new CatalogModel(title: "热门话题", icon: "5", subTitle: "时事热议"),
  ];

  late List<Widget> catalogWidget = [];
  late TabController _tabController =
      new TabController(length: tabs.length, vsync: this);

  late List<MyCard> cards = [];
  int flag = 1;
  var getFollow;

  @override
  void initState() {
    super.initState();
    _setCatalog();
    getFollow = followed();
    cards = List.generate(
        20,
        (index) => MyCard(
              future: Api.getFollow,
              fn: onPressed,
              blogModel: BlogModel(
                intro: "",
                author: "neko",
                title: "上港夺冠花120亿?明面上花69亿 仅2018年就花23亿$index",
                likeCount: 1000,
                commentCount: 1000,
                id: 1,
                imageUrl:
                    "https://img1.baidu.com/it/u=2376967614,180517037&fm=253&fmt=auto&app=120&f=JPEG?w=775&h=500",
              ),
            ));
  }

  var banner = Container(
    width: double.infinity,
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(vertical: 12),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
        color: Colors.pink, borderRadius: BorderRadius.all(Radius.circular(6))),
    child: Text(
      "千万易友交流社区",
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );

  Widget _buildCatalog() {
    return Container(
      height: 70,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: catalogs.length,
          itemBuilder: catalogItemBuilder),
    );
  }

  Widget _buildCatalogItem(CatalogModel catalog) {
    return SizedBox(
      width: 180,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: Color(0xEEEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Image.asset(
                "images/icons/${catalog.icon}.png",
                width: 40,
                height: 40,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  catalog.title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  catalog.subTitle,
                  style: TextStyle(color: Colors.pink),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget catalogItemBuilder(BuildContext context, int index) {
    return catalogWidget[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Container(
          width: 200,
          child: TabBar(
            indicator: CircleIndicator(),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.pink,
            labelColor: Colors.pink,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: [
              Text(
                "推荐",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "广场",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              banner,
              _buildCatalog(),
              Column(
                children: _buildContent(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setCatalog() {
    catalogWidget = catalogs.map((e) => _buildCatalogItem(e)).toList();
  }

  List<Widget> _buildContent() {
    return cards;
    // return ListView.builder(shrinkWrap: true, itemBuilder: itemBuilder);
  }

  void onPressed() {
    setState(() {});
  }

  Future<int> followed() async {
    await Future.delayed(Duration(seconds: 2));
    if (flag == 0) {
      flag = 1;
      return Future.value(0);
    }
    flag = 0;
    return Future.value(1);
  }

  Widget itemBuilder(BuildContext context, int index) {
    return cards[index];
  }
}
