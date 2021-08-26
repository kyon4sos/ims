import 'package:flutter/material.dart';
import 'package:ims/pages/chat_page.dart';
import 'package:ims/pages/mine.dart';

import 'home.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var _curIdx = 0;
  var pages = [HomePage(), ChatPage(), MinePage()];
  var bottomBar = {"home": "主页", "msg": "圈子", "mine": "我的"};
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _setPages();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onPressedBottomBar(idx) {
    this.setState(() {
      _curIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavBar(),
      body: pages[_curIdx],
    );
  }

  _buildBottomNavBar() {
    return BottomNavigationBar(
      items: _buildBottomNavBarItem(),
      onTap: onPressedBottomBar,
      currentIndex: _curIdx,
    );
  }

  _buildBottomNavBarItem() {
    return bottomBar.entries
        .map((e) => BottomNavigationBarItem(
            activeIcon: Image.asset(
              "images/${e.key}-act.png",
              height: 22,
              width: 22,
            ),
            icon: Image.asset(
              "images/${e.key}.png",
              height: 22,
              width: 22,
            ),
            label: e.value))
        .toList();
  }

  _setPages() {}
}
