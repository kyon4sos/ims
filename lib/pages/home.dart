import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ims/api/api.dart';
import 'package:ims/components/custom_indicator.dart';
import 'package:ims/model/news.dart';
import 'package:ims/pages/views/follow_new.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var _homeScaffoldKey = new GlobalKey<ScaffoldState>();

  var tabs = ["关注", "头条", "体育", "财经", "娱乐"];
  List<Widget> tabViews = [];
  List<News> newsList = [];
  late var _tabController = new TabController(length: tabs.length, vsync: this);

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    _setTabViews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeScaffoldKey,
      appBar: _buildAppBar(),
      body: _buildBody(),
      drawer: _buildDrawer(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: _buildAvatar(),
        onPressed: openDrawer,
      ),
      title: _searchInput(),
      actions: [
        IconButton(onPressed: onPressedAction, icon: Icon(Icons.sms_outlined))
      ],
    );
  }

  void onPressedAction() {}
  Widget _searchInput() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 36.0),
      child: TextField(
        style: TextStyle(
            // fontStyle: FontStyle.normal,
            ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.white54,
            ),
            hintText: "请输入内容",
            filled: true,
            fillColor: Colors.black12),
      ),
    );
  }

  _buildAvatar() {
    return CircleAvatar(
      backgroundImage: AssetImage("images/avatar.jpg"),
    );
  }

  openDrawer() {
    _homeScaffoldKey.currentState!.openDrawer();
  }

  _buildDrawer() {
    return Drawer(
      semanticLabel: "drawer",
      child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 40, left: 12, bottom: 12),
            decoration: BoxDecoration(color: Colors.pink),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: CircleAvatar(
                        radius: 32.0,
                        backgroundImage: AssetImage("images/avatar.jpg"),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.qr_code_scanner,
                          color: Colors.white,
                          size: 30,
                        ))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("neko",
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white)),
                      child: Text("LV5",
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(4)),
                      child: Text("正式会员",
                          style: TextStyle(fontSize: 12, color: Colors.pink)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBody() {
    return Container(
      child: Column(
        children: [_buildTabBar(), _buildTabBarView()],
      ),
    );
  }

  // Widget _futureBuilder(BuildContext context, AsyncSnapshot snapshot) {
  //   if (snapshot.hasError) {
  //     return Text(snapshot.error.toString());
  //   }
  //   if (snapshot.hasData) {
  //     return Container(
  //       child: Column(
  //         children: [_buildTabBar(), _buildTabBarView()],
  //       ),
  //     );
  //   }
  //   return Container(
  //       alignment: Alignment.center, child: CircularProgressIndicator());
  // }

  _buildTabBar() {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: TabBar(
          indicator: CircleIndicator(),
          labelColor: Colors.pink,
          unselectedLabelColor: Colors.black54,
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: tabs.map((e) => Text(e)).toList()),
    );
  }

  _buildTabBarView() {
    return Expanded(
        child: TabBarView(
      controller: _tabController,
      children: _buildViews(),
    ));
  }

  _buildViews() {
    return tabViews;
  }

  _buildPageView() {
    return PageView.builder(itemBuilder: _pageViewItemBuilder);
  }

  Widget _pageViewItemBuilder(BuildContext context, int index) {
    return _getTabView(index);
  }

  _getTabView(int index) {
    return tabViews[index];
  }

  _setTabViews() {
    tabViews.add(FollowNew());
    tabViews.add(FollowNew());
    tabViews.add(FollowNew());
    tabViews.add(FollowNew());
    tabViews.add(FollowNew());
  }
}
