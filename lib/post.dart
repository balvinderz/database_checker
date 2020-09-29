import 'package:http/http.dart';

class Post {
  int id;
  String message;
  Post(this.id,this.message);

  Post.fromJson(dynamic json):
      id = json['post_id'],
      message = json['message'];

}