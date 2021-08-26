class BlogModel {
  int id;
  String author;
  String title;
  int likeCount;
  int commentCount;
  String imageUrl;
  String intro;
  BlogModel(
      {required this.id,
      required this.author,
      required this.title,
      required this.likeCount,
      required this.commentCount,
      required this.intro,
      required this.imageUrl});
}
