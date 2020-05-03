class Comment {
  String userId;
  String userName;
  String userLinkPicture;
  DateTime postDate;
  int numberOfLike;
  String isAnsweringTo;
  String text;

  Comment(this.userId, this.text, this.numberOfLike, this.postDate, this.userName, this.userLinkPicture, this.isAnsweringTo);
}