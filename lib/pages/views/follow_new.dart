import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ims/api/api.dart';
import 'package:ims/model/news.dart';

class FollowNew extends StatefulWidget {
  FollowNew();

  @override
  _FollowNewState createState() => _FollowNewState();
}

class _FollowNewState extends State<FollowNew> {
  List<News> items = [];

  late ScrollController _listViewController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _onRefresh,
      child: Container(
          alignment: Alignment.center,
          child: FutureBuilder(future: Api.getNews(), builder: _futureBuilder)),
    ));
  }

  @override
  void initState() {
    super.initState();
    _listViewController.addListener(() {
      bool isBottom = _listViewController.position.pixels ==
          _listViewController.position.maxScrollExtent;
      if (isBottom) {
        loadMore();
      }
    });
  }

  void loadMore() async {
    List<News> ret = await Api.getNews();
    setState(() {
      items.addAll(ret);
    });
  }
  // _setItems() async {
  //   List<Widget> newsWidget = news
  //       .map((e) => Container(
  //             child: Row(
  //               children: [Image.network(e.image), Text(e.title)],
  //             ),
  //           ))
  //       .toList();
  //   items.addAll(newsWidget);
  // }

  // Widget builder(BuildContext context, AsyncSnapshot snapshot) {
  //   return ListView.builder(itemCount: items.length, itemBuilder: itemBuilder);
  // }

  Widget _futureBuilder(
      BuildContext context, AsyncSnapshot<List<News>> snapshot) {
    if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }
    if (snapshot.hasData) {
      items.addAll(snapshot.data!.toList());
      return ListView.builder(
          controller: _listViewController,
          itemCount: items.length,
          itemBuilder: _listItemBuilder);
    }
    return CircularProgressIndicator();
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 4, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            items[index].image,
            width: 120,
            height: 50,
          ),
          Expanded(
            child: Text(
              items[index].title,
              maxLines: 2,
              style: TextStyle(),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    List<News> news = await Api.getNews();
    items.clear();
    setState(() {
      items.addAll(news);
    });
  }
}
