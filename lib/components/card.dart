import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ims/model/Blog.dart';

class MyCard extends StatefulWidget {
  late final VoidCallback fn;
  late final BlogModel blogModel;
  late final Function future;

  MyCard({required this.fn, required this.blogModel, required this.future});

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  var fu = Future.value(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        children: [buildCardHeader(), buildCardBody(), buildFooter()],
      ),
    );
  }

  buildFooter() {
    return Container(
      decoration: BoxDecoration(
          border: BorderDirectional(top: BorderSide(color: Color(0xDDDDDDDD)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: onPressedLike, icon: Icon(Icons.thumb_up_off_alt)),
              Text("${widget.blogModel.likeCount}")
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: onPressedLike,
                  icon: Icon(Icons.insert_comment_outlined)),
              Text("${widget.blogModel.commentCount}")
            ],
          ),
          IconButton(
              onPressed: onPressedLike, icon: Icon(Icons.share_outlined)),
        ],
      ),
    );
  }

  Widget buildCardBody() {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.blogModel.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          // Text(
          //   widget.blogModel.title,
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          // ),
          Image.network(
            widget.blogModel.imageUrl,
          )
        ],
      ),
    );
  }

  Widget buildCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx3.sinaimg.cn%2Fmw690%2F006IV4YMgy1gtm0zng90vj60u00u0myx02.jpg&refer=http%3A%2F%2Fwx3.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632468330&t=9952ce1556f24725f9e8d2964337b448"),
              ),
            ),
            Text(
              widget.blogModel.author,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        FutureBuilder(future: fu, builder: _buildFutureBuilder),
      ],
    );
  }

  final loading = SizedBox(
      width: 14,
      height: 14,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        color: Colors.white,
      ));

  Widget _buildFutureBuilder(BuildContext context, AsyncSnapshot snapshot) {
    bool f = snapshot.data == 1 ? true : false;
    if (snapshot.connectionState == ConnectionState.waiting) {
      return _buildButton(loading, f);
    }
    if (snapshot.hasData) {
      var text = "";
      if (snapshot.data == 1) {
        text = "已关注";
      }
      if (snapshot.data == 0) {
        text = "关注";
      }
      Widget child = Text(text);
      return _buildButton(child, f);
    }

    return _buildButton(loading, f);
  }

  TextButton _buildButton(Widget child, bool f) {
    return TextButton(
      onPressed: () {
        fu = widget.future();
        setState(() {});
        widget.fn();
      },
      child: child,
      style: buildButtonStyle(f),
    );
  }

  ButtonStyle buildButtonStyle(bool f) {
    return ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(4, 2)),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
        foregroundColor: f
            ? MaterialStateProperty.all(Colors.white)
            : MaterialStateProperty.all(Colors.white),
        backgroundColor: f
            ? MaterialStateProperty.all(Colors.grey)
            : MaterialStateProperty.all(Colors.pink));
  }

  void onPressedLike() {}
}
