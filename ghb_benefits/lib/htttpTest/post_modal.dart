// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
class Post {
 int id;
 String Doc;

 Post(this.id, this.Doc);


  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json['id'] as int,
      json['Doc'] as String,

    );
  }
}



