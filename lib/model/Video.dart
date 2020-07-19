import 'package:pinkvilla_video_app_demo/model/User.dart';

class Video {
  String url;
  int commentCount;
  int likeCount;
  int shareCount;
  String title;
  User user;

  Video(
      {this.url,
      this.commentCount,
      this.likeCount,
      this.shareCount,
      this.title,
      this.user});

  Video.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    commentCount = json['comment-count'];
    likeCount = json['like-count'];
    shareCount = json['share-count'];
    title = json['title'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['comment-count'] = this.commentCount;
    data['like-count'] = this.likeCount;
    data['share-count'] = this.shareCount;
    data['title'] = this.title;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
